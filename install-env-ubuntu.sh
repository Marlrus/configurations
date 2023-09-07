#!/bin/bash

HOME_PATH="/home/${USER}"
GITHUB_EMAIL="36910211+Marlrus@users.noreply.github.com"
GITHUB_NAME="Marlrus"

sudo apt update
sudo apt upgrade
echo "===================== SYSTEM BASE UPDATED ====================="

chmod +x *.sh

sudo apt install curl -y
echo "===================== CURL INSTALLED ====================="

sudo apt install git-all -y
echo "===================== GIT INSTALLED ====================="

git config --global user.email ${GITHUB_EMAIL}
git config --global user.name ${GITHUB_NAME}

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-chrome-stable -y
echo "===================== GOOGLE CHROME INSTALLED ====================="

sudo apt install ranger -y
ln -s ${HOME_PATH}/.dotfiles/rc.conf ${HOME_PATH}/.config/ranger/
echo "===================== RANGER INSTALLED AND CONFIGURED ====================="

sudo apt install ripgrep -y
echo "===================== RIPGREP INSTALLED ====================="

sudo apt install python3-pip -y
echo "===================== PIP INSTALLED ====================="

python3 -m pip install --user --upgrade pynvim
echo "===================== PYNVIM INSTALLED ====================="

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
echo "===================== DOCKER INSTALLED ====================="

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
echo "===================== DOCKER CONFIGURED ====================="

./install-update-lazygit.sh
echo "===================== LAZYGIT INSTALLED ====================="

./install-update-kitty.sh
echo "===================== KITTY INSTALLED AND CONFIGURED ====================="

ln -s ${HOME_PATH}/.dotfiles/.bashprompt ${HOME_PATH}/
echo "source ${HOME_PATH}/.bashprompt" >> ${HOME_PATH}/.bashrc
source ${HOME_PATH}/.bashrc
echo "===================== BASHPROMPT CONFIGURED ====================="

sudo apt install libfuse2 -y
echo "===================== LIBFUSE INSTALLED ====================="

sudo apt install xclip -y
echo "===================== XCLIP INSTALLED ====================="

sudo apt install neofetch -y
echo "===================== NEOFETCH INSTALLED ====================="
neofetch

./install-nvim-latest.sh
source ~/.bashrc
echo "===================== NVIM LATEST INSTALLED ====================="

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "===================== VIM PLUG INSTALLED ====================="

ln -s ${HOME_PATH}/.dotfiles/nvim/ ${HOME_PATH}/.config
echo "===================== NVIM CONFIG UPDATED IN HOME ====================="

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ${HOME_PATH}/.nvm/nvm.sh
source ${HOME_PATH}/.profile
source ${HOME_PATH}/.bashrc
nvm install --lts
echo "===================== NVM INSTALLED ====================="

npm i -g prettier
echo "===================== PRETTIER INSTALLED ====================="

./install-npm-lsp-servers.sh

./install-terraform-ls-lsp.sh

./install-lsp-terraform-ls.sh

echo "===================== NVIM LSPS INSTALLED ====================="

echo "Please run nvim and run the command :PlugInstall to get all of the packages installed in the nvim env"
