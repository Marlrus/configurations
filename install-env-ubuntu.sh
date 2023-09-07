CONFIG_URL="/home/${USER}/.config"

sudo apt update
sudo apt upgrade
echo "===================== SYSTEM BASE UPDATED ====================="

sudo apt install curl -y
echo "===================== CURL INSTALLED ====================="

sudo apt install git-all -y
echo "===================== GIT INSTALLED ====================="

git config --global user.email "36910211+Marlrus@users.noreply.github.com"
git config --global user.name "Marlrus"

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-chrome-stable -y
echo "===================== GOOGLE CHROME INSTALLED ====================="

sudo apt install ranger -y
ln -s /home/${USER}/.dotfiles/rc.conf /home/${USER}/.config/ranger/
echo "===================== RANGER INSTALLED AND CONFIGURED ====================="

sudo apt install ripgrep -y
echo "===================== RIPGREP INSTALLED ====================="

sudo apt install python3-pip -y
echo "===================== PIP INSTALLED ====================="

python3 -m pip install --user --upgrade pynvim
echo "===================== PYNVIM INSTALLED ====================="

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
echo "===================== DOCKER INSTALLED ====================="

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
echo "===================== DOCKER CONFIGURED ====================="

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit*
echo "===================== LAZYGIT INSTALLED ====================="

chmod +x ./install-update-kitty.sh
./install-update-kitty.sh
echo "===================== KITTY INSTALLED ====================="

mkdir ${CONFIG_URL}/kitty
cp ./kitty.conf ${CONFIG_URL}/kitty
echo "===================== KITTY CONFIGURED ====================="

ln -s /home/${USER}/.dotfiles/.bashprompt /home/${USER}/
echo "source /home/${USER}/.bashprompt" >> /home/${USER}/.bashrc
source /home/${USER}/.bashrc
echo "===================== BASHPROMPT CONFIGURED ====================="

sudo apt install libfuse2 -y
echo "===================== LIBFUSE INSTALLED ====================="

sudo apt install xclip -y
echo "===================== XCLIP INSTALLED ====================="

sudo apt install neofetch -y
echo "===================== NEOFETCH INSTALLED ====================="
neofetch

chmod +x ./install-nvim-latest.sh
./install-nvim-latest.sh
source ~/.bashrc
echo "===================== NVIM LATEST INSTALLED ====================="

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "===================== VIM PLUG INSTALLED ====================="

ln -s /home/${USER}/.dotfiles/nvim/ /home/${USER}/.config
echo "===================== NVIM CONFIG UPDATED IN HOME ====================="

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source /home/${USER}/.bashrc
nvm install --lts
echo "===================== NVM INSTALLED ====================="

npm i -g prettier
echo "===================== PRETTIER INSTALLED ====================="

chmod +x ./install-lsp-servers.sh
./install-npm-lsp-servers.sh

chmod +x ./install-terraform-ls-lsp.sh
./install-terraform-ls-lsp.sh

chmod +x ./install-lsp-efm.sh
./install-lsp-terraform-ls.sh

echo "===================== NVIM LSPS INSTALLED ====================="

echo "Please run nvim and run the command :PlugInstall to get all of the packages installed in the nvim env"
