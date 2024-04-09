#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "POSTGRES INSTALLATION/UPDATE BEGINNING"

sudo apt install postgresql postgresql-contrib

FN_PRINT_GREEN_BANNER "POSTGRES INSTALLED/UPDATED"
