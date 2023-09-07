HOME_PATH="/home/${USER}"

sudo apt install golang-go -y
echo "===================== GOLANG INSTALLED ====================="

if ! command grep -qc  '/go/bin' ${HOME_PATH}/.profile; then
  echo "Adding Path for go in .profile"
  printf '\nif [ -d "$HOME/go/bin" ] ; then\n    PATH="$HOME/go/bin:$PATH"\nfi\n' >>  ${HOME_PATH}/.profile
  source ${HOME_PATH}/.profile
  echo "Path for go added to profile"
else
  echo "path for go found in .profile"
fi

go install github.com/mattn/efm-langserver@latest
echo "===================== EFM LSP INSTALLED ====================="
