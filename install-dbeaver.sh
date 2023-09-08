#!/bin/bash

GREEN="\033[0;32m"
NO_COLOR="\033[0m"

sudo add-apt-repository ppa:serge-rider/dbeaver-ce -y
sudo apt update -y
sudo apt install dbeaver-ce -y
printf "${GREEN}===================== DBEAVER INSTALLED =====================${NO_COLOR}\n\n"
