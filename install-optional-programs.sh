#!/bin/bash

sudo snap install keep-presence
echo "===================== KEEP PRESENCE INSTALLED ====================="

sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt install obs-studio -y
echo "===================== OBS INSTALLED ====================="
