#!/bin/sh

source ~/Documents/phone/bash-scripts/config.sh

img=(`find /home/$user_pine/Documents/phone/wallpapers -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | cut -d':' -f1`)

#while true
#do

#/usr/bin/feh --bg-scale --randomize /home/$user_pine/Documents/phone/wallpapers/*

#echo "${img[$RANDOM % ${#img[@]} ]}"

gsettings set org.gnome.desktop.background picture-uri "file://${img[$RANDOM % ${#img[@]} ]}"


#sleep 10m
#done
# sh ~/Documents/phone/bash-scripts/gnome-change-background.sh




