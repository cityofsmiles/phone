#!/bin/sh

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak install flathub org.libreoffice.LibreOffice
