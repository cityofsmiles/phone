#!/bin/sh

#img=(`find /home/jonathan/Documents/wallpapers -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | cut -d':' -f1`)

while true
do

feh --bg-scale --randomize ~/Documents/phone/wallpapers/*

#   feh --bg-scale "${img[$RANDOM % ${#img[@]} ]}"
sleep 1m
done
