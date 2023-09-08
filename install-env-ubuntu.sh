#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "SYSTEM INSTALLATION BEGINNING"

sudo apt update
sudo apt upgrade
FN_PRINT_GREEN_BANNER "SYSTEM BASE UPDATED"

chmod +x *.sh

sudo apt install curl -y
FN_PRINT_GREEN_BANNER "CURL INSTALLED"

sudo apt install git-all -y
FN_PRINT_GREEN_BANNER "GIT INSTALLED"

git config --global user.email ${GITHUB_EMAIL}
git config --global user.name ${GITHUB_NAME}

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-chrome-stable -y
FN_PRINT_GREEN_BANNER "GOOGLE CHROME INSTALLED"

sudo apt install ranger -y
ln -s ${HOME_PATH}/.dotfiles/rc.conf ${HOME_PATH}/.config/ranger/
FN_PRINT_GREEN_BANNER "RANGER INSTALLED AND CONFIGURED"

sudo apt install ripgrep -y
FN_PRINT_GREEN_BANNER "RIPGREP INSTALLED"

sudo apt install python3-pip -y
FN_PRINT_GREEN_BANNER "PIP INSTALLED"

python3 -m pip install --user --upgrade pynvim
FN_PRINT_GREEN_BANNER "PYNVIM INSTALLED"

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
FN_PRINT_GREEN_BANNER "DOCKER INSTALLED"

./install-dbeaver.sh
FN_PRINT_GREEN_BANNER "DBEAVER INSTALLED"

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
FN_PRINT_GREEN_BANNER "DOCKER CONFIGURED"

./install-update-lazygit.sh
FN_PRINT_GREEN_BANNER "LAZYGIT INSTALLED"

./install-update-kitty.sh
FN_PRINT_GREEN_BANNER "KITTY INSTALLED AND CONFIGURED"

ln -s ${HOME_PATH}/.dotfiles/.bashprompt ${HOME_PATH}/
echo "source ${HOME_PATH}/.bashprompt" >> ${HOME_PATH}/.bashrc
source ${HOME_PATH}/.bashrc
FN_PRINT_GREEN_BANNER "BASHPROMPT CONFIGURED"

sudo apt install libfuse2 -y
FN_PRINT_GREEN_BANNER "LIBFUSE INSTALLED"

sudo apt install xclip -y
FN_PRINT_GREEN_BANNER "XCLIP INSTALLED"

sudo apt install neofetch -y
FN_PRINT_GREEN_BANNER "NEOFETCH INSTALLED"
neofetch

./install-nvim-latest.sh
source ~/.bashrc
FN_PRINT_GREEN_BANNER "NVIM LATEST INSTALLED"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
FN_PRINT_GREEN_BANNER "VIM PLUG INSTALLED"

ln -s ${HOME_PATH}/.dotfiles/nvim/ ${HOME_PATH}/.config
FN_PRINT_GREEN_BANNER "NVIM CONFIG UPDATED IN HOME"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ${HOME_PATH}/.nvm/nvm.sh
source ${HOME_PATH}/.profile
source ${HOME_PATH}/.bashrc
nvm install --lts
FN_PRINT_GREEN_BANNER "NVM INSTALLED"

npm i -g prettier
FN_PRINT_GREEN_BANNER "PRETTIER INSTALLED"

./install-npm-lsp-servers.sh

./install-terraform-ls-lsp.sh

./install-lsp-terraform-ls.sh

FN_PRINT_GREEN_BANNER "NVIM LSPS INSTALLED"

FN_PRINT_GREEN_BANNER "run nvim and run the command :PlugInstall to get all of the packages installed in the nvim env"
