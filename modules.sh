HOME_PATH="/home/${USER}"
GREEN="\033[0;32m"
NO_COLOR="\033[0m"
GITHUB_EMAIL="36910211+Marlrus@users.noreply.github.com"
GITHUB_NAME="Marlrus"

function FN_PRINT_GREEN_BANNER(){
  printf "\n${GREEN}[==================== $1 ====================]${NO_COLOR}\n\n"
}

function FN_ERR_EXIT(){
  echo "Error: $1"
  exit 1
}
