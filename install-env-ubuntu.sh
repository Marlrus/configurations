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

sudo apt install ripgrep -y
FN_PRINT_GREEN_BANNER "RIPGREP INSTALLED/UPDATED"

sudo apt install git -y
FN_PRINT_GREEN_BANNER "GIT INSTALLED/UPDATED"

if ! [ $(git config --global --list | rg ${GITHUB_EMAIL} | wc -l) = 1 ] && ! [ $(git config --global --list | rg ${GITHUB_NAME} | wc -l ) = 1 ]; then
  FN_PRINT_YELLOW "Git config does not match variables in modules file. Configuring global git user."
  git config --global user.email ${GITHUB_EMAIL}
  git config --global user.name ${GITHUB_NAME}
else 
  FN_PRINT_YELLOW "Git config mathches variables, skipping git config."
fi

if ! [ -L ${HOME_PATH}/.config/ranger/rc.conf ]; then
  FN_PRINT_YELLOW "ranger configuration not found. Adding rc.conf"
  ln -s ${HOME_PATH}/.dotfiles/rc.conf ${HOME_PATH}/.config/ranger/
  FN_PRINT_GREEN_BANNER "RANGER INSTALLED AND CONFIGURED"
else
  FN_PRINT_YELLOW "ranger configuration found."
fi

./install-update-lazygit.sh

./install-update-kitty.sh

ln -s ${HOME_PATH}/.dotfiles/.bashprompt ${HOME_PATH}/
echo "source ${HOME_PATH}/.bashprompt" >> ${HOME_PATH}/.bashrc
source ${HOME_PATH}/.bashrc
FN_PRINT_GREEN_BANNER "BASHPROMPT CONFIGURED"

# Comes default v 3-4 on Ubuntu 26.xx
# sudo apt install libfuse2 -y
# FN_PRINT_GREEN_BANNER "LIBFUSE INSTALLED/UPDATED"

sudo apt install xclip -y
FN_PRINT_GREEN_BANNER "XCLIP INSTALLED/UPDATED"

sudo apt install fastfetch -y
FN_PRINT_GREEN_BANNER "FASTFETCH INSTALLED"
fastfetch

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

FN_PRINT_GREEN_BANNER "NVIM LSPS INSTALLED/UPDATED"

FN_PRINT_GREEN_BANNER "run nvim and run the command :PlugInstall to get all of the packages installed in the nvim env"

./install-dbeaver.sh
