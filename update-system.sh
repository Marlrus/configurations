#!/bin/bash

GREEN="\033[0;32m"
NO_COLOR="\033[0m"

function err_exit(){
  echo "Error: $1"
  exit 1
}

sudo apt update && sudo apt -y upgrade ||
err_exit "Error updating with apt"

printf "${GREEN}===================== PACKAGE MANAGER PACKAGES UPDATED =====================${NO_COLOR}\n\n"

./update-dev-packages.sh ||
err_exit "Error updating with dev-packages.sh"

printf "${GREEN}===================== SYSTEM UPDATED =====================${NO_COLOR}\n\n"
