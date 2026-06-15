#!/bin/bash

# IMPORTS
source ./modules.sh

if ! [ $(apt list --installed | rg google-chrome-stable | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Google Chrome not Installed, installing google-chrome-stable"
  curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes -o /usr/share/keyrings/google-chrome.gpg
  # wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  printf '%s\n' \
  'Types: deb' \
  'URIs: https://dl.google.com/linux/chrome/deb/' \
  'Suites: stable' \
  'Components: main' \
  'Architectures: amd64' \
  'Signed-By: /usr/share/keyrings/google-chrome.gpg' \
  | sudo tee /etc/apt/sources.list.d/google-chrome.sources > /dev/null
  # sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo apt update
  sudo apt install google-chrome-stable -y
  FN_PRINT_GREEN_BANNER "GOOGLE CHROME INSTALLED"
else
  FN_PRINT_YELLOW "Google Chrome is already installed."
fi
