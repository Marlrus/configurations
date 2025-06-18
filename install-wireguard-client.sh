#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "WIREGUARD CLIENT INSTALLATION BEGINNING"

if ! [ $(apt list --installed | rg wireguard | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "wireguard not installed"
  sudo apt install wireguard
  FN_PRINT_GREEN_BANNER "wireguard installed"
else
  FN_PRINT_YELLOW "wireguard installed, will update on the regular apt udate/upgrade cycle."
fi

FN_PRINT_GREEN_BANNER "WIREGUARD CLIENT INSTALLED/UPDATED"
