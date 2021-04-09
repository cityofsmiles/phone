#!/bin/sh

#source ~/Documents/phone/bash-scripts/config.sh

#img=(`find /home/jonathan/Documents/wallpapers -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | cut -d':' -f1`)

while true
do

/usr/bin/feh --bg-scale --randomize /home/alarm/Documents/phone/wallpapers/*

#   feh --bg-scale "${img[$RANDOM % ${#img[@]} ]}"
sleep 10m
done
