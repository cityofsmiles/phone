#!/bin/sh

git config --global user.email "cityofsmiles@gmail.com"

git config --global user.name "cityofsmiles"

git config --global pull.rebase false

cd /home/jonathan/Documents/phone

git remote -v

git remote set-url origin git@github.com:cityofsmiles/phone.git

git auth login

