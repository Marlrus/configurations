#!/bin/bash

sprintNumber=30

function currentsprint() {
  echo "Moving very fast!"
  cd "/home/marlrus/Dropbox/habi/2021sprints/${sprintNumber}sprint"
}

function habirepos() {
  echo "VROOM!"
  cd "/home/marlrus/webDev/habi"
}

function personaldev() {
				echo "Go get em!"
				cd "/home/marlrus/Dropbox/pDevelopment"
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
  cd "/home/${USER}/.config/nvim" && vim init.vim
}

function vimtodo() {
  cd "/home/${USER}/webDev/vim" && vim todo.md
}

function logicamorsa() {
  cd "/home/${USER}/Dropbox/logicaMorsa"
}

function kittyconfig() {
  cd "/home/${USER}/.config/kitty" && vim kitty.conf
}

function snippets() {
  cd "/home/${USER}/.config/nvim/snippets"
}

function business() {
  cd "/home/${USER}/Dropbox/sidBusiness"
}

