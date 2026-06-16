#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "OPTIONAL PROGRAM INSTALLATION BEGINNING"

sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt install obs-studio -y
FN_PRINT_GREEN_BANNER "OBS INSTALLED"

sudo snap install vlc
FN_PRINT_GREEN_BANNER "VLC INSTALLED"

# sudo snap install steam
sudo snap install postman

# sudo apt install darktable
# sudo apt install rawtherapee

sudo apt install pandoc
