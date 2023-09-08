#!/bin/bash

# IMPORTS
source ./modules.sh

./install-update-kitty.sh &&
./install-nvim-latest.sh &&
./install-update-lazygit.sh

printf "${GREEN}===================== DEV PACKAGES INSTALLED/UPDATED =====================${NO_COLOR}\n\n"
