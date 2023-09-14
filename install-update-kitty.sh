#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "KITTY INSTALLATION/UPDATE BEGINNING"

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Check if kitty is installed
if [ -e /usr/bin/kitty ]; then
  FN_PRINT_YELLOW "Kitty found, no need to create symlink."
else
  FN_PRINT_YELLOW "Kitty not found, creating symilink"
  sudo ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten /usr/bin/
fi

# Check if desktop images exist
if [ -f ${HOME_PATH}/.local/share/applications/kitty.desktop ] && [ -f ${HOME_PATH}/.local/share/applications/kitty-open.desktop ]; then
  FN_PRINT_YELLOW "Kitty desktop images found, no need to copy desktop images."
else
  FN_PRINT_YELLOW "Kitty desktop not found, copying desktop image."
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
  sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
  sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
  FN_PRINT_YELLOW "Kitty desktop images copied to ~/.local/share/applications/."
fi

# Set Kitty as default terminal
if [ $(update-alternatives --display x-terminal-emulator | rg "kitty.*priority 50" | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Kitty already set as default terminal."
else
  FN_PRINT_YELLOW "Setting Kitty as default terminal."
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 50
fi

# Set Kitty Configuration with symlink
if ! [ -L ${HOME_PATH}/.config/kitty/kitty.conf ]; then
  FN_PRINT_YELLOW "Kitty configuration not found. Adding kitty.conf"
  mkdir ${HOME_PATH}/.config/kitty
  ln -s ${HOME_PATH}/.dotfiles/kitty.conf ${HOME_PATH}/.config/kitty/
else
  FN_PRINT_YELLOW "Kitty configuration found."
fi

FN_PRINT_GREEN_BANNER "KITTY INSTALLED/UPDATED"
