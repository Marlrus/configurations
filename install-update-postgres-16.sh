#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "POSTGRES 16 INSTALLATION/UPDATE BEGINNING"

if ! [ $(apt list --installed | rg postgresql-16 | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "postgres-16 not installed, installing postgres-16"
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
else
  FN_PRINT_YELLOW "terraform-ls is already installed, updating terraform-ls"
fi

sudo apt update
sudo apt install postgresql-16 postgresql-contrib-16

FN_PRINT_GREEN_BANNER "POSTGRES 16 INSTALLED/UPDATED"
