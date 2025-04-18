#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "OPENVPN CLIENT INSTALLATION BEGINNING"

if ! [ $(apt list --installed | rg apt-transport-https | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "apt-transport-https not installed"
  sudo apt install apt-transport-https
  FN_PRINT_GREEN_BANNER "apt-transport-https installed"
else
  FN_PRINT_YELLOW "apt-transport-https installed"
fi

if ! [ $(apt list --installed | rg openvpn3 | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "openvpn3 not installed"
  sudo sh -c 'curl -sSfL https://packages.openvpn.net/packages-repo.gpg >/etc/apt/keyrings/openvpn.asc'
  # UPDATE RELEASE
  sudo sh -c 'echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian jammy main" >>/etc/apt/sources.list.d/openvpn3.list'
  sudo apt update
  sudo apt install openvpn3
  FN_PRINT_GREEN_BANNER "openvpn3 installed"
else
  FN_PRINT_YELLOW "openvpn3 installed, will update on the regular apt udate/upgrade cycle."
fi

FN_PRINT_GREEN_BANNER "OPENVPN CLIENT INSTALLED/UPDATED"
