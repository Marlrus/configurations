#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "Installing Pro Audio Packages"

if ! [ $(apt list --installed | rg pulseaudio-utils | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Installing pulseaudio-utils"

  sudo apt install pulseaudio-utils -y

  FN_PRINT_GREEN_BANNER "pulseaudio-utils installed"
else
  FN_PRINT_YELLOW "pulseaudio-utils are already installed"
fi

if ! [ $(apt list --installed | rg pulseaudio-utils | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Installing Pipewire JACK Utils"

  sudo apt install pipewire-jack qpwgraph jack-example-tools -y

  FN_PRINT_GREEN_BANNER "Pipewire JACK Utils installed"

  FN_PRINT_YELLOW "Configuring Global Pipewire JACK settings for clockrate"

  mkdir -p ~/.config/pipewire/pipewire.conf.d
cat > ~/.config/pipewire/pipewire.conf.d/10-clock.conf <<'EOF'
context.properties = {
    default.clock.rate = 48000
    default.clock.allowed-rates = [ 48000 ]
}
EOF
  systemctl --user restart pipewire pipewire-pulse
else
  FN_PRINT_YELLOW "Pipewire JACK Utils already installed"
fi

FN_PRINT_GREEN_BANNER "Pro-Audio Installed and Configured"
