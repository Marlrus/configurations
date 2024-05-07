#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "DEV PACKAGES INSTALLATION/UPDATE BEGINNING"

./install-update-kitty.sh &&
./install-nvim-latest.sh &&
./install-update-lazygit.sh
./install-update-terminator.sh
./install-update-postgres-16.sh
./install-update-mongo-7.sh

FN_PRINT_GREEN_BANNER "DEV PACKAGES INSTALLED/UPDATED"
