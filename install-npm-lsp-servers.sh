#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "NPM LSP SERVERS INSTALLATION FOR CURRENT NODE VERSION BEGINNING"

npm i -g vscode-langservers-extracted
npm install -g typescript typescript-language-server
npm install -g graphql-language-service-cli
npm i -g yaml-language-server
npm i -g bash-language-server
npm install -g vim-language-server

FN_PRINT_GREEN_BANNER "NPM LSP SERVERS INSTALLED FOR CURRENT NODE VERSION"
