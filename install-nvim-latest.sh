#!/bin/bash

HOME_PATH="/home/${USER}"
GREEN="\033[0;32m"
NO_COLOR="\033[0m"

if [ -x "$(command -v python3 -V)" ]; then
  echo "Python 3 found."
else
  echo "Python 3 not found, please install"
  exit 1
fi

if [ -x "$(command -v pip -V)" ]; then
  echo "Pip found."
else
  echo "Pip not found, installing pip."
  sudo apt install python3-pip -y
  printf "${GREEN}===================== PIP INSTALLED =====================${NO_COLOR}\n\n"
fi

if [ $(pip list | rg "pynvim" | wc -l) = 1 ]; then
  echo "Pynvim found."
else
  echo "Pynvim not found, installing pynvim."
  python3 -m pip install --user --upgrade pynvim
  printf "${GREEN}===================== PYNVIM INSTALLED =====================${NO_COLOR}\n\n"
fi

function err_exit(){
  echo $1
  echo "Restoring previous NVIM version"
  cp ${HOME_PATH}/nvim.appimage-prev ${HOME_PATH}/nvim.appimage
  chmod +x ${HOME_PATH}/nvim.appimage
  exit 1
}

# Create backup
if [ -f ${HOME_PATH}/nvim.appimage ]; then
  if [ -f ${HOME_PATH}/nvim.appimage-prev ]; then
    mv ${HOME_PATH}/nvim.appimage ${HOME_PATH}/nvim.appimage-prev
  fi
  rm ${HOME_PATH}/nvim.appimage
fi

wget -q --show-progress https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P ${HOME_PATH}/ &&
echo "Nvim latest dowloaded to home directory." ||
err_exit "Error dowloading NVIM"

wget -q --show-progress https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage.sha256sum -P ${HOME_PATH}/ &&
echo "Downloading Checksum" ||
err_exit "Error dowloading NVIM Checksum"

if [ -f ${HOME_PATH}/nvim.appimage ] && [ -f ${HOME_PATH}/nvim.appimage.sha256sum ]; then
  echo "Verifying checksum"
  # In case checksum changes
  CHECKSUM=$(awk '{print $1}' ${HOME_PATH}/nvim.appimage.sha256sum)
  if [[ $(sha256sum ${HOME_PATH}/nvim.appimage | awk '{print $1}') != $CHECKSUM ]]; then
    err_exit "Checksum not matching"
  else
    echo "Checksum matches."
  fi
  rm ${HOME_PATH}/nvim.appimage.sha256sum
  chmod +x ${HOME_PATH}/nvim.appimage
  echo "Execution permissions added to nvim"
  if ! command grep -qc  '/nvim.appimage' ${HOME_PATH}/.bashrc; then
    echo "Appending nvim alias to bash .bashrc"
    printf '\nalias nvim="/home/${USER}/nvim.appimage"\n' >> ${HOME_PATH}/.bashrc
    source ${HOME_PATH}/.bashrc
  else
    echo "alias for nvim appimage found."
  fi
else
  err_exit "NVIM app image not found" 
fi

printf "${GREEN}===================== NVIM INSTALLED =====================${NO_COLOR}\n\n"
printf "${GREEN}\n===================== CHECKING NVIM VERSION =====================${NO_COLOR}\n\n"
${HOME_PATH}/nvim.appimage -v
