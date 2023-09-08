#!/bin/bash

HOME_PATH="/home/${USER}"
GREEN="\033[0;32m"
NO_COLOR="\033[0m"

sudo apt install golang-go -y
printf "${GREEN}===================== GOLANG INSTALLED =====================${NO_COLOR}\n\n"

if ! command grep -qc  '/go/bin' ${HOME_PATH}/.profile; then
  echo "Adding Path for go in .profile"
  printf '\nif [ -d "$HOME/go/bin" ] ; then\n    PATH="$HOME/go/bin:$PATH"\nfi\n' >>  ${HOME_PATH}/.profile
  source ${HOME_PATH}/.profile
  echo "Path for go added to profile"
else
  echo "path for go found in .profile"
fi

go install github.com/mattn/efm-langserver@latest
printf "${GREEN}===================== EFM LSP INSTALLED =====================${NO_COLOR}\n\n"
