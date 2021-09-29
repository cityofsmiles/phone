#!/usr/bin/bash

cd /home/jonathan/Pictures

day=$( date +"%F_%H-%M-%S" )

origname="$( xsel -b -o )"

echo 'Type filename'

read filename

mv $origname $filename-$day.png && notify-send "screenshot saved"



