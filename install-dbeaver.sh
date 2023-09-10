#!/bin/bash

# IMPORTS
source ./modules.sh

if [ $(apt list --installed | rg dbeaver-ce | wc -l) = 0 ]; then
  echo "dbeaver-ce is not installed, installing dbeaver-ce"
  FN_PRINT_GREEN_BANNER "DBEAVER INSTALLATION BEGINNING"
  sudo add-apt-repository ppa:serge-rider/dbeaver-ce -y
  sudo apt update -y
  sudo apt install dbeaver-ce -y
  FN_PRINT_GREEN_BANNER "DBEAVER INSTALLED"
else 
  echo "dbeaver-ce is already installed."
fi
