#!/bin/bash

# Remove Old Version
yum remove docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-engine

# Set up the repository
yum install -y yum-utils
yum-config-manager --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker Engine
yum install docker-ce docker-ce-cli containerd.io

# Start Docker
systemctl start docker
systemctl enable docker

# Test
#docker run hello-world

# Uninstall
#yum remove docker-ce docker-ce-cli containerd.io
#rm -rf /var/lib/docker
#rm -rf /var/lib/containerd
