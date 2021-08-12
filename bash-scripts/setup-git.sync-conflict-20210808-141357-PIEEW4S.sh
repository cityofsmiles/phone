#!/bin/sh

ssh-keygen -t rsa -C "cityofsmiles@gmail.com"

val "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa

git config --global user.email "cityofsmiles@gmail.com"

git config --global user.name "cityofsmiles"

git config --global pull.rebase false

cd ~/Documents/phone

git remote -v

git remote set-url origin git@github.com:cityofsmiles/phone.git

gh auth login


