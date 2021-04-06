#!/bin/sh

sudo yay -S flatpak
#sudo apk add flatpak

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak install flathub com.gitlab.newsflash
