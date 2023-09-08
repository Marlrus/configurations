#!/bin/bash

# IMPORTS
source ./modules.sh

sudo apt update
sudo apt upgrade
printf "${GREEN}===================== SYSTEM BASE UPDATED =====================${NO_COLOR}\n\n"

chmod +x *.sh

sudo apt install curl -y
printf "${GREEN}===================== CURL INSTALLED =====================${NO_COLOR}\n\n"

sudo apt install git-all -y
printf "${GREEN}===================== GIT INSTALLED =====================${NO_COLOR}\n\n"

git config --global user.email ${GITHUB_EMAIL}
git config --global user.name ${GITHUB_NAME}

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-chrome-stable -y
printf "${GREEN}===================== GOOGLE CHROME INSTALLED =====================${NO_COLOR}\n\n"

sudo apt install ranger -y
ln -s ${HOME_PATH}/.dotfiles/rc.conf ${HOME_PATH}/.config/ranger/
printf "${GREEN}===================== RANGER INSTALLED AND CONFIGURED =====================${NO_COLOR}\n\n"

sudo apt install ripgrep -y
printf "${GREEN}===================== RIPGREP INSTALLED =====================${NO_COLOR}\n\n"

sudo apt install python3-pip -y
printf "${GREEN}===================== PIP INSTALLED =====================${NO_COLOR}\n\n"

python3 -m pip install --user --upgrade pynvim
printf "${GREEN}===================== PYNVIM INSTALLED =====================${NO_COLOR}\n\n"

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
printf "${GREEN}===================== DOCKER INSTALLED =====================${NO_COLOR}\n\n"

./install-dbeaver.sh
printf "${GREEN}===================== DBEAVER INSTALLED =====================${NO_COLOR}\n\n"

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
printf "${GREEN}===================== DOCKER CONFIGURED =====================${NO_COLOR}\n\n"

./install-update-lazygit.sh
printf "${GREEN}===================== LAZYGIT INSTALLED =====================${NO_COLOR}\n\n"

./install-update-kitty.sh
printf "${GREEN}===================== KITTY INSTALLED AND CONFIGURED =====================${NO_COLOR}\n\n"

ln -s ${HOME_PATH}/.dotfiles/.bashprompt ${HOME_PATH}/
echo "source ${HOME_PATH}/.bashprompt" >> ${HOME_PATH}/.bashrc
source ${HOME_PATH}/.bashrc
printf "${GREEN}===================== BASHPROMPT CONFIGURED =====================${NO_COLOR}\n\n"

sudo apt install libfuse2 -y
printf "${GREEN}===================== LIBFUSE INSTALLED =====================${NO_COLOR}\n\n"

sudo apt install xclip -y
printf "${GREEN}===================== XCLIP INSTALLED =====================${NO_COLOR}\n\n"

sudo apt install neofetch -y
printf "${GREEN}===================== NEOFETCH INSTALLED =====================${NO_COLOR}\n\n"
neofetch

./install-nvim-latest.sh
source ~/.bashrc
printf "${GREEN}===================== NVIM LATEST INSTALLED =====================${NO_COLOR}\n\n"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
printf "${GREEN}===================== VIM PLUG INSTALLED =====================${NO_COLOR}\n\n"

ln -s ${HOME_PATH}/.dotfiles/nvim/ ${HOME_PATH}/.config
printf "${GREEN}===================== NVIM CONFIG UPDATED IN HOME =====================${NO_COLOR}\n\n"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ${HOME_PATH}/.nvm/nvm.sh
source ${HOME_PATH}/.profile
source ${HOME_PATH}/.bashrc
nvm install --lts
printf "${GREEN}===================== NVM INSTALLED =====================${NO_COLOR}\n\n"

npm i -g prettier
printf "${GREEN}===================== PRETTIER INSTALLED =====================${NO_COLOR}\n\n"

./install-npm-lsp-servers.sh

./install-terraform-ls-lsp.sh

./install-lsp-terraform-ls.sh

printf "${GREEN}===================== NVIM LSPS INSTALLED =====================${NO_COLOR}\n\n"

printf "${GREEN}Please run nvim and run the command :PlugInstall to get all of the packages installed in the nvim env${NO_COLOR}\n\n"
