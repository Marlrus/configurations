#!/bin/bash

# IMPORTS
source ./modules.sh

if [ $(ls ${HOME_PATH}/.dotfiles/vscode-js-debug/dist/src | rg dapDebugServer.js | wc -l) = 0 ]; then
  FN_PRINT_YELLOW "vscode-js-debug is not installed. Installing"
  mkdir ${HOME_PATH}/.dotfiles/vscode-js-debug
  git clone git@github.com:microsoft/vscode-js-debug.git ${HOME_PATH}/.dotfiles/vscode-js-debug
  npm install --ignore-scripts --prefix ${HOME_PATH}/.dotfiles/vscode-js-debug
  npm run --prefix ${HOME_PATH}/.dotfiles/vscode-js-debug compile dapDebugServer
  FN_PRINT_GREEN_BANNER "vscode-js-debug INSTALLED"
else
  FN_PRINT_YELLOW "vscode-js-debug is already installed."
fi
