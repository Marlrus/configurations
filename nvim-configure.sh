#!/bin/bash

# IMPORTS
source ./modules.sh

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
FN_PRINT_GREEN_BANNER "VIM PLUG INSTALLED/UPDATED"


ln -s ${HOME_PATH}/.dotfiles/nvim/ ${HOME_PATH}/.config
FN_PRINT_GREEN_BANNER "NVIM CONFIG UPDATED IN HOME"
