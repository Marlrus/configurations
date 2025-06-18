#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "PROTONVPN CLIENT INSTALLATION BEGINNING"

if ! [ $(apt list --installed | rg proton-vpn-gnome-desktop | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "protonvpn not installed"
  wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb
  sudo dpkg -i ./protonvpn-stable-release_1.0.8_all.deb
  sudo apt update
  sudo apt install proton-vpn-gnome-desktop
  FN_PRINT_GREEN_BANNER "protonvpn installed"
else
  FN_PRINT_YELLOW "protonvpn installed, will update on the regular apt udate/upgrade cycle."
fi

FN_PRINT_GREEN_BANNER "PROTONVPN CLIENT INSTALLED/UPDATED"
