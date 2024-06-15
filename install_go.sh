#!/bin/bash

set -o errexit -o nounset -o pipefail

# Install the most recent version of Go.
readonly VERSION=$(curl https://go.dev/VERSION?m=text 2>/dev/null | head -n1)
readonly ARCH=$(uname -m | sed -e 's/aarch64/arm64/g' -e 's/x86_64/amd64/g')
readonly GO_ARCHIVE=${VERSION}.linux-${ARCH}.tar.gz
curl -O https://dl.google.com/go/${GO_ARCHIVE}
tar -C /usr/local -xzf ${GO_ARCHIVE}
rm ${GO_ARCHIVE}

PATH=$PATH:/usr/local/go/bin

# Install the Amazon ECR Credential helper.
go install github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login@latest
