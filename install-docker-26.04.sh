#!/bin/bash

# IMPORTS
source ./modules.sh

if [ $(docker -v | wc -l) = 0 ]; then
  FN_PRINT_YELLOW "docker is not installed, installing docker"
  sudo apt update
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
  FN_PRINT_YELLOW "Docker apt Repository configured"
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  FN_PRINT_GREEN_BANNER "DOCKER INSTALLED"

  # Execute docker without sudo
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  FN_PRINT_GREEN_BANNER "DOCKER GROUP CONFIGURED"
else 
  FN_PRINT_YELLOW "docker is already installed."
fi
