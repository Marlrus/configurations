#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "JS DEBUGGER DEPENDENCY INSTALLATION/UPDATE BEGINNING"

git clone https://github.com/microsoft/vscode-js-debug
cd vscode-js-debug
npm install --legacy-peer-deps
npx gulp vsDebugServerBundle
mv dist out

FN_PRINT_GREEN_BANNER "JS DEBUGGER DEPENDENCY INSTALLED/UPDATED"
