#!/bin/bash

sprintNumber=3
month="march"
currentCourse="/home/marlrus/webDev/learning/fireship/nextJs/nextfire-app"

function coursecurrent() {
  cd "${currentCourse}"
}

function gitlocal() {
  cd "/home/marlrus/webDev/templatesAndDefaults" && vim githublocalconfig
}

function currentsprint() {
  echo "Moving very fast!"
  cd "/home/marlrus/Dropbox/luca/2021/sprint${sprintNumber}"
}

function lucaRepos() {
  echo "VROOM!"
  cd "/home/marlrus/webDev/luca"
}

function todo() {
  echo "Go get em!"
  cd "/home/marlrus/Dropbox/newLife" && vim ${month}Todo.md
}

function gratjournal() {
  echo "Write fast!"
  cd "/home/marlrus/Dropbox/pDevelopment/writing/journaling" && vim q1gratJournaling.md 
}

function devsshtunel() {
  cd /home/marlrus/.ssh/ && 
  sudo ssh -f -N -L 3307:habi-qa-aurora-serverless-cluster.cluster-cauboia6qzrb.us-east-2.rds.amazonaws.com:3306 -i ssh-tunnel-key-QA.pem ubuntu@3.128.162.42
}

function devgoals() {
  cd "/home/marlrus/webDev" && vim .goals.md
}

function vimcheatsheet() {
  cd "/home/marlrus/webDev/vim" && vim cheatSheet.md
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

function brokers() {
  cd "/home/marlrus/webDev/habi/habi-brokers"
}

