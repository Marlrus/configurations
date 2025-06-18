#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "POSTGRES 17 INSTALLATION/UPDATE BEGINNING"

if ! [ $(apt list --installed | rg postgresql-17 | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "postgres-17 not installed, installing postgres-17"
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
else
  FN_PRINT_YELLOW "postgres-17 is already installed, updating terraform-ls"
fi

sudo apt update
sudo apt install postgresql-17 postgresql-contrib-17

FN_PRINT_GREEN_BANNER "POSTGRES 17 INSTALLED/UPDATED"
