#!/bin/bash

sprintNumber=3
month="march"
currentCourse="/home/${USER}/webDev/learning/fireship/nextJs/nextfire-app"

function coursecurrent() {
  cd "${currentCourse}"
}

function gitlocal() {
  cd "/home/${USER}/webDev/templatesAndDefaults" 
  vim githublocalconfig
}

function currentsprint() {
  echo "Moving very fast!"
  cd "/home/${USER}/Dropbox/luca/2021/sprint${sprintNumber}"
}

function lucarepos() {
  cd "/home/${USER}/webDev/luca"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/luca_edu
}

function repos() {
  cd "/home/${USER}/webDev/personalSites"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
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
  cd "/home/${USER}/Dropbox/pDevelopment/writing/journaling" && vim q1gratJournaling.md 
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

