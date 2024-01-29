#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "SYSTEM INSTALLATION BEGINNING"

sudo apt update
sudo apt upgrade
FN_PRINT_GREEN_BANNER "SYSTEM BASE UPDATED"

chmod +x *.sh

sudo apt install curl -y
FN_PRINT_GREEN_BANNER "CURL INSTALLED/UPDATED"

sudo apt install git-all -y
FN_PRINT_GREEN_BANNER "GIT INSTALLED/UPDATED"

if ! [ $(git config --global --list | rg ${GITHUB_EMAIL} | wc -l) = 1 ] && [ $(git config --global --list | rg ${GITHUB_NAME} | wc -l ) = 1 ]; then
  FN_PRINT_YELLOW "Git config does not match variables in modules file. Configuring global git user."
  git config --global user.email ${GITHUB_EMAIL}
  git config --global user.name ${GITHUB_NAME}
else 
  FN_PRINT_YELLOW "Git config mathches variables, skipping git config."
fi

if ! [ $(apt list --installed | rg google-chrome-stable | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Google Chrome not Installed, installing google-chrome-stable"
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo apt update
  sudo apt install google-chrome-stable -y
  FN_PRINT_GREEN_BANNER "GOOGLE CHROME INSTALLED"
else
  FN_PRINT_YELLOW "Google Chrome is already installed."
fi

if ! [ -L ${HOME_PATH}/.config/ranger/rc.conf ]; then
  FN_PRINT_YELLOW "ranger configuration not found. Adding rc.conf"
  ln -s ${HOME_PATH}/.dotfiles/rc.conf ${HOME_PATH}/.config/ranger/
  FN_PRINT_GREEN_BANNER "RANGER INSTALLED AND CONFIGURED"
else
  FN_PRINT_YELLOW "ranger configuration found."
fi

sudo apt install ripgrep -y
FN_PRINT_GREEN_BANNER "RIPGREP INSTALLED/UPDATED"

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

./install-dbeaver.sh

./install-update-lazygit.sh

./install-update-kitty.sh

ln -s ${HOME_PATH}/.dotfiles/.bashprompt ${HOME_PATH}/
echo "source ${HOME_PATH}/.bashprompt" >> ${HOME_PATH}/.bashrc
source ${HOME_PATH}/.bashrc
FN_PRINT_GREEN_BANNER "BASHPROMPT CONFIGURED"

sudo apt install libfuse2 -y
FN_PRINT_GREEN_BANNER "LIBFUSE INSTALLED/UPDATED"

sudo apt install xclip -y
FN_PRINT_GREEN_BANNER "XCLIP INSTALLED/UPDATED"

sudo apt install neofetch -y
FN_PRINT_GREEN_BANNER "NEOFETCH INSTALLED"
neofetch

./install-nvim-latest.sh
source ~/.bashrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
FN_PRINT_GREEN_BANNER "VIM PLUG INSTALLED/UPDATED"

ln -s ${HOME_PATH}/.dotfiles/nvim/ ${HOME_PATH}/.config
FN_PRINT_GREEN_BANNER "NVIM CONFIG UPDATED IN HOME"

source ${HOME_PATH}/.nvm/nvm.sh
source ${HOME_PATH}/.profile
source ${HOME_PATH}/.bashrc
if [ $(nvm -v | wc -l) != 1 ]; then
  FN_PRINT_YELLOW "nvm not found. Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  source ${HOME_PATH}/.nvm/nvm.sh
  source ${HOME_PATH}/.profile
  source ${HOME_PATH}/.bashrc
  nvm install --lts
  FN_PRINT_GREEN_BANNER "NVM INSTALLED"
else
  FN_PRINT_YELLOW "nvm installation found"
fi

npm i -g prettier
FN_PRINT_GREEN_BANNER "PRETTIER INSTALLED/UPDATED"

./install-npm-lsp-servers.sh

./install-lsp-terraform-ls.sh

./install-lsp-efm.sh

./install-lsp-golang.sh

FN_PRINT_GREEN_BANNER "NVIM LSPS INSTALLED/UPDATED"

./install-debuger-js.sh

FN_PRINT_GREEN_BANNER "NVIM DEBUGGER DEPENDENCIES INSTALLED"

FN_PRINT_GREEN_BANNER "run nvim and run the command :PlugInstall to get all of the packages installed in the nvim env"
