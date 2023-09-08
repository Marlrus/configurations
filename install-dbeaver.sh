#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "DBEAVER INSTALLATION BEGINNING"
sudo add-apt-repository ppa:serge-rider/dbeaver-ce -y
sudo apt update -y
sudo apt install dbeaver-ce -y
FN_PRINT_GREEN_BANNER "DBEAVER INSTALLED"
