#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "TERRAFORM LS LSP INSTALLATION/UPDATE BEGINNING"

if ! [ $(apt list --installed | rg terraform-ls | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "terraform-ls not installed, installing terraform-ls"
  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
else
  FN_PRINT_YELLOW "terraform-ls is already installed, updating terraform-ls"
fi

sudo apt update
sudo apt install terraform-ls -y
FN_PRINT_GREEN_BANNER "TERRAFORM LS LSP INSTALLED/UPDATED"
