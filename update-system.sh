#!/bin/bash

function err_exit(){
  echo "Error: $1"
  exit 1
}

sudo apt update && sudo apt -y upgrade ||
err_exit "Error updating with apt"

./update-dev-packages.sh ||
err_exit "Error updating with dev-packages.sh"
