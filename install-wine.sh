#!/bin/bash
# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "WINE INSTALLATION BEGINNING"

if ! [ $(apt list --installed 2>/dev/null | rg "^wine64/" | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Wine not installed, beginning installation..."

  # Ensure Universe repository is enabled (required for wine64 on 26.04)
  FN_PRINT_YELLOW "Ensuring Universe repository is enabled..."
  sudo add-apt-repository -y universe

  # Update apt
  sudo apt update

  # Install wine64 (64-bit only)
  FN_PRINT_YELLOW "Installing wine64..."
  sudo apt install -y wine64

  # Verify wine binary is available
  if ! command -v wine &> /dev/null; then
    FN_PRINT_YELLOW "ERROR: Wine installation failed — binary not found in PATH."
    exit 1
  fi

  # Install winetricks
  FN_PRINT_YELLOW "Installing winetricks..."
  sudo apt install -y winetricks

  FN_PRINT_GREEN_BANNER "Wine $(wine --version) installed successfully."
else
  FN_PRINT_YELLOW "Wine already installed ($(wine --version)), will update on the regular apt update/upgrade cycle."
fi

FN_PRINT_GREEN_BANNER "WINE INSTALLATION COMPLETE"
