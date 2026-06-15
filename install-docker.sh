if [ $(docker -v | wc -l) = 0 ]; then
  FN_PRINT_YELLOW "docker is not installed, installing docker"
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
  FN_PRINT_GREEN_BANNER "DOCKER INSTALLED"

  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  FN_PRINT_GREEN_BANNER "DOCKER CONFIGURED"
else 
  FN_PRINT_YELLOW "docker is already installed."
fi
