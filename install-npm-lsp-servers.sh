#!/bin/bash

GREEN="\033[0;32m"
NO_COLOR="\033[0m"

npm i -g vscode-langservers-extracted
npm install -g typescript typescript-language-server
npm install -g graphql-language-service-cli
npm i -g yaml-language-server
npm i -g bash-language-server
npm install -g vim-language-server

printf "${GREEN}===================== NPM LSP SERVERS INSTALLED FOR CURRENT NODE VERSION =====================${NO_COLOR}\n\n"
