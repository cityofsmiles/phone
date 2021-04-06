#!/bin/sh

sudo pacman -S xfce4-terminal okular vlc rsync inotify-tools texstudio mousepad github-cli pidgin pidgin-xmpp-receipts pidgin-hotkeys pidgin-libnotify purple-facebook purple-plugin-pack libreoffice chromium purple-telegram telegram-desktop quickddit flatpak texlive-most python-telegram-send #yay 

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak install flathub com.gitlab.newsflash


