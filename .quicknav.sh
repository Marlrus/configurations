#!/bin/bash

sprintNumber=23
month="march"
currentCourse="/home/${USER}/webDev/learning/fireship/nextJs/nextfire-app"
githubUser="Marlrus"
githubEmail="36910211+Marlrus@users.noreply.github.com"
gitlabUser="Julian"
gitlabEmail="julian.franco.f@hyrecar.com"
JOURNAL_FILE="q4gratJournaling.md"

function coursecurrent() {
  cd "${currentCourse}"
}

function projectcurrent() {
  cd ~/webDev/personalSites/warlrus-cli/
  vim .
}

function kbb() {
  cd "/home/${USER}/Dropbox/kbb"
}

function gitlocal() {
  cd "/home/${USER}/webDev/templatesAndDefaults" 
  vim githublocalconfig
}

function currentsprint() {
  echo "Moving very fast!"
  cd "/home/${USER}/Dropbox/hyrecar/sprint${sprintNumber}"
}

function nextRepoPopulate() {
  echo "Setting up NextJS structure"
  rm yarn.lock
  echo "Removed yarn.lock"
  echo "Installing Dev Packages"
  npm i -D typescript @types/react @types/node prettier @types/node-sass @types/react-dom
  echo "Dev Packages Installed"
  echo "Installing npm packages"
  npm i sass env-cmd
  echo "npm packages Installed"
  echo "Creating root files"
  touch tsconfig.json prettier.config.js .env.development .env.local .env.production
  echo "Root files created"
  echo "Creating directories"
  mkdir atoms molecules organisms sections hooks contexts services types utils
  echo "Directories created"
  echo "Remember to change package.json to use local, dev, and prod scritps"
}

function lucarepos() {
  cd "/home/${USER}/webDev/luca"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/luca_edu
}

function hyrecarerepos() {
  cd "/home/${USER}/webDev/hyrecar"
  echo "Sourcing scripts..."
  source "/home/${USER}/webDev/hyrecar/scripts/hyrecarScripts.sh"
  echo "Scripts sourced"
}

function repos() {
  cd "/home/${USER}/webDev/personalSites"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
}

function personalGithub() {
  git config --local user.name ${githubUser}
  git config --local user.email ${githubEmail}
}

function sethyrecargithub() {
  git config --local user.name ${gitlabUser}
  git config --local user.email ${gitlabEmail}
}

function marlrus() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
}

function todo() {
  echo "Go get em!"
  cd "/home/${USER}/Dropbox/newLife" && vim ${month}Todo.md
}

function gratjournal() {
  echo "Write fast!"
  cd "/home/${USER}/Dropbox/pDevelopment/writing/journaling" && vim $JOURNAL_FILE
}

function devgoals() {
  cd "/home/${USER}/webDev" && vim .goals.md
}

function lifebook() {
  echo "Great success!"
  cd "/home/${USER}/Dropbox/pDevelopment/lifebook2021" 
}

function viminit() {
  cd "/home/${USER}/.dotfiles/nvim" && vim init.vim
}

function logicamorsa() {
  cd "/home/${USER}/Dropbox/logicaMorsa"
}

function kittyconfig() {
  cd "/home/${USER}/.dotfiles" && vim kitty.conf
}

function snippets() {
  cd "/home/${USER}/.config/nvim/snippets"
}

function dotfiles() {
  cd "/home/${USER}/.dotfiles"
}

function tzlist() {
  timedatectl list-timezones | cat
}

function tohtml() {
  echo "Type input file"
  read INPUT
  echo "Select output file name without .html extension"
  read FILENAME
  echo "Select css (retrocss)"
  read CSS

  pandoc $INPUT -o $FILENAME.html -H ~/markdowncss/$CSS
}

function printbetweenlines() {
  echo "Start line"
  read START
  echo "End line"
  read END

  awk '{if(NR >= ${START} && NR <= ${END}) print NR, $0' $1
}

# function gotofilelocation() {
#   IFS=""
#   FILE_NAME=$1
#   LIST=$(tree -f -i -a | rg ${FILE_NAME} | awk -v FS=/ ' 
#   {
#     out=$2;

#     for(i=3;i<NF;i++){
#       out=out"/"$i
#     };

#     print out
#   }')
#   ARRAY=($(echo -e $LIST ))
#   echo Select Option:
#   for i in "${!ARRAY[@]}"
#   do
#     echo $i
#     echo "${i}) ${ARRAY[$i]}"
#   done
# }

function killalldockers() {
  docker container kill $(docker ps -q)
}
