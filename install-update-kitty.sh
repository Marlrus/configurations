HOME_PATH="/home/${USER}"

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Check if kitty is installed
if [ -e /usr/bin/kitty ]; then
  echo "Kitty found, no need to create symlink."
else
  echo "Kitty not found, creating symilink"
  sudo ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten /usr/bin/
fi

# Check if desktop images exist
if [ -f ${HOME_PATH}/.local/share/applications/kitty.desktop ] && [ -f ${HOME_PATH}/.local/share/applications/kitty-open.desktop ]; then
  echo "Kitty desktop images found, no need to copy desktop images."
else
  echo "Kitty desktop not found, copying desktop image."
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
  sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
  sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
  echo "Kitty desktop images copied to ~/.local/share/applications/."
fi

# Set Kitty as default terminal
if [ $(update-alternatives --display x-terminal-emulator | rg "kitty.*priority 50" | wc -l) = 1 ]; then
  echo "Kitty already set as default terminal."
else
  echo "Setting Kitty as default terminal."
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 50
fi

# Set Kitty Configuration
if [ -f ${HOME_PATH}/.config/kitty/kitty.conf ]; then
  echo "Kitty configuration found."
else
  echo "Kitty configuration not found. Adding kitty.conf"
  mkdir ${CONFIG_URL}/kitty
  cp ./kitty.conf ${CONFIG_URL}/kitty
fi
