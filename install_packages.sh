#!/bin/bash

set -o errexit -o nounset -o pipefail

apt-get update

export DEBIAN_FRONTEND="noninteractive"
export TZ="Etc/UTC"

apt-get install --yes \
    apt-transport-https \
    build-essential \
    ca-certificates \
    clang \
    curl \
    git \
    make \
    python3 \
    python3-pip \
    software-properties-common \
    unzip \
    zip \
    zstd

ln -s "$(which python3)" /usr/bin/python

# Clean up so this isn't kept in the layer.
rm -rf /var/lib/apt/lists/*
