HOME_PATH="/home/${USER}"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m" 
NO_COLOR="\033[0m"
GITHUB_EMAIL="36910211+Marlrus@users.noreply.github.com"
GITHUB_NAME="Marlrus"

function FN_PRINT_GREEN_BANNER(){
  printf "\n${GREEN}[==================== $1 ====================]${NO_COLOR}\n\n"
}

function FN_PRINT_YELLOW(){
  printf "${YELLOW}$1${NO_COLOR}\n"
}

function FN_ERR_EXIT(){
  printf "${RED}Error:${NO_COLOR} $1\n"
  exit 1
}
