#!/bin/bash

GREEN="\033[0;32m"
NO_COLOR="\033[0m"

./install-update-kitty.sh &&
./install-nvim-latest.sh &&
./install-update-lazygit.sh

printf "${GREEN}===================== DEV PACKAGES INSTALLED/UPDATED =====================${NO_COLOR}\n\n"
