#!/bin/sh

sxmo_keyboard.sh close

cd /home/jonathan/Pictures

if [ "$1" = "selection" ]; then
	notify-send "select an area" && scrot -e 'echo $f | xsel -i -b' -d 1 -s -q 1 
else
	scrot -e 'echo $f | xsel -i -b' -d 1 -q 1 
fi

sxmo_keyboard.sh open

st /mnt/sdcard/Documents/phone/bash-scripts/get-input.sh

