#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "SYSTEM UPDATE BEGINNING"

sudo apt update && sudo apt -y upgrade ||
FN_ERR_EXIT "Error updating with apt"

sudo cp -r /usr/libexec/docker/cli-plugins/docker-compose /usr/lib/docker/cli-plugins/docker-compose

FN_PRINT_GREEN_BANNER "PACKAGE MANAGER PACKAGES UPDATED"

./update-dev-packages.sh ||
FN_ERR_EXIT "Error updating with dev-packages.sh"

FN_PRINT_GREEN_BANNER "SYSTEM UPDATED"
