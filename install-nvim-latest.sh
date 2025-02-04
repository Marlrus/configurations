#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "NVIM INSTALLATION/UPDATE BEGINNING"

if [ -x "$(command -v python3 -V)" ]; then
  FN_PRINT_YELLOW "Python 3 found."
else
  FN_PRINT_YELLOW "Python 3 not found, please install"
  exit 1
fi

if [ -x "$(command -v pip -V)" ]; then
  FN_PRINT_YELLOW "Pip found."
else
  FN_PRINT_YELLOW "Pip not found, installing pip."
  sudo apt install python3-pip -y
  FN_PRINT_GREEN_BANNER "PIP INSTALLED"
fi

if [ $(pip list | rg "pynvim" | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Pynvim found."
else
  FN_PRINT_YELLOW "Pynvim not found, installing pynvim."
  python3 -m pip install --user --upgrade pynvim
  FN_PRINT_GREEN_BANNER "INSTALLED"
fi

# Create backup
if [ -f ${HOME_PATH}/nvim.appimage ]; then
  cp ${HOME_PATH}/nvim.appimage ${HOME_PATH}/nvim.appimage-prev
  rm ${HOME_PATH}/nvim.appimage
fi

wget -q --show-progress https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage -P ${HOME_PATH}/ &&
mv ${HOME_PATH}/nvim-linux-x86_64.appimage ${HOME_PATH}/nvim.appimage
FN_PRINT_YELLOW "Nvim latest dowloaded to home directory." ||
FN_ERR_EXIT "Error dowloading NVIM"

wget -q --show-progress https://github.com/neovim/neovim/releases/download/nightly/shasum.txt -P ${HOME_PATH}/ &&
FN_PRINT_YELLOW "Downloading Checksum" ||
FN_ERR_EXIT "Error dowloading NVIM Checksum"

if [ -f ${HOME_PATH}/nvim.appimage ] && [ -f ${HOME_PATH}/shasum.txt ]; then
  FN_PRINT_YELLOW "Verifying checksum"
  # In case checksum changes
  CHECKSUM=$(rg nvim-linux-x86_64.appimage$ ${HOME_PATH}/shasum.txt | awk '{print $1}')
  if [[ $(sha256sum ${HOME_PATH}/nvim.appimage | awk '{print $1}') != $CHECKSUM ]]; then
    cp ${HOME_PATH}/nvim.appimage-prev ${HOME_PATH}/nvim.appimage
    FN_ERR_EXIT "Checksum not matching, reverting nvim to previous appimage"
  else
    FN_PRINT_YELLOW "Checksum matches."
  fi
  rm ${HOME_PATH}/shasum.txt
  chmod +x ${HOME_PATH}/nvim.appimage
  FN_PRINT_YELLOW "Execution permissions added to nvim"
  if ! command grep -qc  '/nvim.appimage' ${HOME_PATH}/.bashrc; then
    FN_PRINT_YELLOW "Appending nvim alias to bash .bashrc"
    printf '\nalias nvim="/home/${USER}/nvim.appimage"\n' >> ${HOME_PATH}/.bashrc
    source ${HOME_PATH}/.bashrc
  else
    FN_PRINT_YELLOW "alias for nvim appimage found."
  fi
else
  cp ${HOME_PATH}/nvim.appimage-prev ${HOME_PATH}/nvim.appimage
  FN_ERR_EXIT "Checksum not matching, reverting nvim to previous appimage"
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
FN_PRINT_GREEN_BANNER "VIM PLUG INSTALLED/UPDATED"

FN_PRINT_GREEN_BANNER "NVIM INSTALLED/UPDATED"

if [ -f ${HOME_PATH}/nvim.appimage-prev ]; then
  FN_PRINT_GREEN_BANNER "PREVIOUS NVIM VERSION"
  ${HOME_PATH}/nvim.appimage-prev -v
fi

FN_PRINT_GREEN_BANNER "NEW NVIM VERSION"
${HOME_PATH}/nvim.appimage -v
