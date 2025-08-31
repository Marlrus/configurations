#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "OPENSHOT INSTALLATION BEGINNING"

if ! [ $(apt list --installed | rg python3-openshot | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "openshot not installed"
  sudo add-apt-repository ppa:openshot.developers/ppa
  sudo apt update
  sudo apt install openshot-qt python3-openshot
  FN_PRINT_GREEN_BANNER "openshot installed"
else
  FN_PRINT_YELLOW "openshot installed"
fi

FN_PRINT_GREEN_BANNER "OPENSHOT INSTALLED"
