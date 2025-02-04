FROM jenkins/jenkins:lts

SHELL ["/bin/bash", "-c"]

# Switch to root while installing packages.
USER root

RUN --mount=source=install_packages.sh,target=/mnt/install_packages.sh,type=bind \
    /mnt/install_packages.sh

RUN --mount=source=install_docker.sh,target=/mnt/install_docker.sh,type=bind \
    /mnt/install_docker.sh

RUN --mount=source=install_go.sh,target=/mnt/install_go.sh,type=bind \
    /mnt/install_go.sh

# Include Go and its binaries in the PATH.
ENV PATH="$PATH:/usr/local/go/bin:/root/.go/bin:/root/go/bin"

# TODO(macourteau): find a way to make /var/run/docker.sock owned by 'jenkins',
# and re-enable this.
# # Drop back to user jenkins post-install as recommended here:
# #   https://github.com/jenkinsci/docker#installing-more-tools
# USER jenkins
