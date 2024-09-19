#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "NPM LSP SERVERS INSTALLATION/UPDATE FOR CURRENT NODE VERSION BEGINNING"

npm i -g vscode-langservers-extracted
npm install -g graphql-language-service-cli
npm i -g yaml-language-server
npm i -g bash-language-server
npm install -g vim-language-server
npm install -g dockerfile-language-server-nodejs
npm install -g @microsoft/compose-language-service
npm install -g nxls
npm install -g typescript-language-server typescript

FN_PRINT_GREEN_BANNER "NPM LSP SERVERS INSTALLED/UPDATED FOR CURRENT NODE VERSION"
