#!/bin/sh

cd /home/jonathan/Pictures

if [ "$1" = "selection" ]; then
	notify-send "select an area" && scrot -e 'echo $f | xsel -i -b' -d 1 -s -q 1 
else
	scrot -e 'echo $f | xsel -i -b' -d 1 -q 1 
fi

origname="$( xsel -b -o )"

clear

echo 'Type filename'

read filename

mv $origname $filename.png && notify-send "screenshot saved"
