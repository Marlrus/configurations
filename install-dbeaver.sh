#!/bin/bash

# IMPORTS
source ./modules.sh

sudo add-apt-repository ppa:serge-rider/dbeaver-ce -y
sudo apt update -y
sudo apt install dbeaver-ce -y
printf "${GREEN}===================== DBEAVER INSTALLED =====================${NO_COLOR}\n\n"
