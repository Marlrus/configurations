#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "SYSTEM UPDATE BEGINNING"

sudo apt update && sudo apt -y upgrade ||
FN_ERR_EXIT "Error updating with apt"

FN_PRINT_GREEN_BANNER "PACKAGE MANAGER PACKAGES UPDATED"

./update-dev-packages.sh ||
FN_ERR_EXIT "Error updating with dev-packages.sh"

FN_PRINT_GREEN_BANNER "SYSTEM UPDATED"
