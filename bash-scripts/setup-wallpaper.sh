#!/bin/sh

sudo cp /home/alarm/Documents/phone/bash-scripts/wallpaper.service /etc/systemd/system/

sudo cp /home/alarm/Documents/phone/bash-scripts/feh-change-background.sh /usr/bin/wallpaper

sudo chmod 755 /usr/bin/wallpaper

sudo systemctl enable wallpaper.service

sudo systemctl start wallpaper.service
