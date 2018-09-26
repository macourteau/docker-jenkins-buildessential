FROM jenkins/jenkins:lts

# Switch to root while installing packages.
USER root

# Install docker-ce according to the instructions here:
#   https://docs.docker.com/install/linux/docker-ce/debian/
# Also installs build-essential and clang.
RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/docker-gpg && \
    apt-key add /tmp/docker-gpg && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable" && \
   apt-get update && \
   apt-get -y install build-essential clang docker-ce

# Drop back to user jenkins post-install as recommended here:
#   https://github.com/jenkinsci/docker#installing-more-tools
USER jenkins
