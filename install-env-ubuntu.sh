CONFIG_URL="/home/${USER}/.config"

sudo apt update
sudo apt upgrade

sudo apt install curl -y

sudo apt install git-all -y

git config --global user.email "36910211+Marlrus@users.noreply.github.com"
git config --global user.name "Marlrus"

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-chrome-stable -y

sudo apt install ranger -y

sudo apt install ripgrep -y

sudo apt install python3-pip -y

python3 -m pip install --user --upgrade pynvim

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten /usr/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 50

mkdir ${CONFIG_URL}/kitty
cp ./kitty.conf ${CONFIG_URL}/kitty

ln -s /home/${USER}/.dotfiles/.bashprompt /home/${USER}/
echo "source /home/${USER}/.bashprompt" >> /home/${USER}/.bashrc
source /home/${USER}/.bashrc

sudo apt install libfuse2 -y

chmod +x ./install-nvim-latest.sh
./install-nvim-latest.sh
source ~/.bashrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit*

ln -s /home/${USER}/.dotfiles/nvim/ /home/${USER}/.config

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source /home/${USER}/.bashrc
nvm install --lts

npm i -g vscode-langservers-extracted
npm install -g typescript typescript-language-server
npm install -g graphql-language-service-cli
npm i -g yaml-language-server
npm i -g bash-language-server
npm install -g vim-language-server

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform-ls

echo "Please run nvim and run the command :PlugInstall to get all of the packages installed in the nvim env"
