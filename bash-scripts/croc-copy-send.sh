#!/bin/sh

xdotool key --clearmodifiers Ctrl+c

str="$( xsel -b -o )"

croc send --code jobacsbakulawcityofsmiles87 --text "$str"

&& notify-send "Clipboard entry sent."