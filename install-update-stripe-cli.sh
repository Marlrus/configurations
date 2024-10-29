#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "STRIPE CLI INSTALLATION/UPDATE BEGINNING"

if [ $(stripe -v | wc -l) = 0 ]; then
  FN_PRINT_YELLOW "Stripe CLI is not installed, installing Stripe CLI"
  curl -s https://packages.stripe.dev/api/security/keypair/stripe-cli-gpg/public | gpg --dearmor | sudo tee /usr/share/keyrings/stripe.gpg
  echo "deb [signed-by=/usr/share/keyrings/stripe.gpg] https://packages.stripe.dev/stripe-cli-debian-local stable main" | sudo tee -a /etc/apt/sources.list.d/stripe.list
  sudo apt update
  sudo apt install stripe -y
  FN_PRINT_GREEN_BANNER "STRIPE CLI INSTALLED"
else 
  FN_PRINT_YELLOW "Stripe CLI is already installed, updating"
  sudo apt install stripe -y
fi

FN_PRINT_GREEN_BANNER "STRIPE CLI INSTALLED/UPDATED"
