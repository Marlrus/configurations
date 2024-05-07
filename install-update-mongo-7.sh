#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "MONGO 7 INSTALLATION/UPDATE BEGINNING"

if ! [ $(apt list --installed | rg mongodb-org-server | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "mongo 7 not installed, installing mongo 7"
  curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
     sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
     --dearmor
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
else
  FN_PRINT_YELLOW "mongo 7 is already installed, updating mongo 7"
fi

sudo apt update
sudo apt install mongodb-org

FN_PRINT_GREEN_BANNER "MONGO 7 INSTALLED/UPDATED"
