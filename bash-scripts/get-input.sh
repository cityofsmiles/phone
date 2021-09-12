#!/usr/bin/bash

cd /home/jonathan/Pictures

#sxmo_keyboard.sh open 

origname="$( xsel -b -o )"

echo 'Type filename'

read filename

mv $origname $filename.png && notify-send "screenshot saved"



