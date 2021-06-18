#!/bin/bash

sprintNumber=10
month="march"
currentCourse="/home/${USER}/webDev/learning/fireship/nextJs/nextfire-app"
githubUser="Marlrus"
githubEmail="36910211+Marlrus@users.noreply.github.com"
gitlabUser="Julian"
gitlabEmail="julian.franco.f@hyrecar.com"

function coursecurrent() {
  cd "${currentCourse}"
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
  cd "/home/${USER}/Dropbox/pDevelopment/writing/journaling" && vim q2gratJournaling.md 
}

function devsshtunel() {
  cd /home/marlrus/.ssh/ && 
  sudo ssh -f -N -L 3307:habi-qa-aurora-serverless-cluster.cluster-cauboia6qzrb.us-east-2.rds.amazonaws.com:3306 -i ssh-tunnel-key-QA.pem ubuntu@3.128.162.42
}

function devgoals() {
  cd "/home/${USER}/webDev" && vim .goals.md
}

function vimcheatsheet() {
  cd "/home/${USER}/webDev/vim" && vim cheatSheet.md
}

function lifebook() {
  echo "Great success!"
  cd "/home/${USER}/Dropbox/pDevelopment/lifebook2021" 
}

function viminit() {
  cd "/home/${USER}/.dotfiles/nvim" && vim init.vim
}

function vimtodo() {
  cd "/home/${USER}/webDev/vim" && vim todo.md
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

function business() {
  cd "/home/${USER}/Dropbox/sidBusiness"
}

function dotfiles() {
  cd "/home/${USER}/.dotfiles"
}

