#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "EFM LSP INSTALLATION/UPDATE BEGINNING"

sudo apt install golang-go -y
FN_PRINT_GREEN_BANNER "GOLANG INSTALLED/UPDATED"

if ! command grep -qc  '/go/bin' ${HOME_PATH}/.profile; then
  FN_PRINT_YELLOW "Adding Path for go in .profile"
  printf '\nif [ -d "$HOME/go/bin" ] ; then\n    PATH="$HOME/go/bin:$PATH"\nfi\n' >>  ${HOME_PATH}/.profile
  source ${HOME_PATH}/.profile
  FN_PRINT_YELLOW "Path for go added to profile"
else
  FN_PRINT_YELLOW "path for go found in .profile"
fi

go install github.com/mattn/efm-langserver@latest
FN_PRINT_GREEN_BANNER "EFM LSP INSTALLED/UPDATED"
