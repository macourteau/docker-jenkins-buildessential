FROM jenkins/jenkins:lts

SHELL ["/bin/bash", "-c"]

# Switch to root while installing packages.
USER root

# Install docker-ce according to the instructions here:
#   https://docs.docker.com/install/linux/docker-ce/debian/
# Also installs build-essential, clang, go and the Amazon ECR Credential Helper.
RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        gnupg \
        make \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/docker-gpg && \
    apt-key add /tmp/docker-gpg && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable" && \
   apt-get update && \
   apt-get -y install build-essential clang docker-ce && \
   # Install the most recent version of Go.
   curl -O https://dl.google.com/go/getgo/installer_linux && \
   chmod +x installer_linux && \
   SHELL=bash ./installer_linux && \
   rm installer_linux && \
   source /root/.bash_profile && \
   # Install the Amazon ECR Credential helper.
   go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login

# Include Go and its binaries in the PATH.
ENV PATH "$PATH:/root/.go/bin:/root/go/bin"

# TODO(macourteau): find a way to make /var/run/docker.sock owned by 'jenkins',
# and re-enable this.
# # Drop back to user jenkins post-install as recommended here:
# #   https://github.com/jenkinsci/docker#installing-more-tools
# USER jenkins
