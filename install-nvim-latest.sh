#!/bin/bash

function err_exit(){
  echo $1
  echo "Restoring previous NVIM version"
  cp ~/nvim.appimage-prev ~/nvim.appimage
  chmod +x ~/nvim.appimage
  exit 1
}

# Create backup
if [ -f ~/nvim.appimage ]; then
  if [ -f ~/nvim.appimage-prev ]; then
    mv ~/nvim.appimage ~/nvim.appimage-prev
  fi
  rm ~/nvim.appimage
fi

wget -q --show-progress https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P ~/ &&
echo "Nvim latest dowloaded to home directory." ||
err_exit "Error dowloading NVIM"

wget -q --show-progress https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage.sha256sum -P ~/ &&
echo "Downloading Checksum" ||
err_exit "Error dowloading NVIM Checksum"

if [ -f ~/nvim.appimage ] && [ -f ~/nvim.appimage.sha256sum ]; then
  echo "Verifying checksum"
  # In case checksum changes
  CHECKSUM=$(awk '{print $1}' ~/nvim.appimage.sha256sum)
  if [[ $(sha256sum ~/nvim.appimage | awk '{print $1}') != $CHECKSUM ]]; then
    err_exit "Checksum not matching"
  else
    echo "Checksum matches."
  fi
  rm ~/nvim.appimage.sha256sum
  chmod +x ~/nvim.appimage
  echo "Execution permissions added to nvim"
  if ! command grep -qc  '/nvim.appimage' ~/.bashrc; then
    echo "Appending nvim and vim alias to bash .bashrc"
    printf '\nalias vim="/home/${USER}/nvim.appimage"\n' >> ~/.bashrc
    echo 'alias nvim="/home/${USER}/nvim.appimage"' >> ~/.bashrc
    source ~/.bashrc
  else
    echo "alias for nvim appimage found."
  fi
else
  err_exit "NVIM app image not found" 
fi
