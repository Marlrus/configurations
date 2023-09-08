#!/bin/bash

# IMPORTS
source ./modules.sh

sudo snap install keep-presence
printf "${GREEN}===================== KEEP PRESENCE INSTALLED =====================${NO_COLOR}\n\n"

sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt install obs-studio -y
printf "${GREEN}===================== OBS INSTALLED =====================${NO_COLOR}\n\n"
