#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "TERMINATOR INSTALLATION/UPDATE BEGINNING"

if ! [ $(apt list --installed | rg terminator | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "terminator not installed, installing terminator"
else
  FN_PRINT_YELLOW "terminator is already installed, updating terminator"
fi

sudo apt install terminator

FN_PRINT_GREEN_BANNER "TERMINATOR INSTALLED/UPDATED"
