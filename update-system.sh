#!/bin/bash

# IMPORTS
source ./modules.sh

sudo apt update && sudo apt -y upgrade ||
FN_ERR_EXIT "Error updating with apt"

printf "${GREEN}===================== PACKAGE MANAGER PACKAGES UPDATED =====================${NO_COLOR}\n\n"

./update-dev-packages.sh ||
FN_ERR_EXIT "Error updating with dev-packages.sh"

printf "${GREEN}===================== SYSTEM UPDATED =====================${NO_COLOR}\n\n"
