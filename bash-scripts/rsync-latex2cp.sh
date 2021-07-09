#!/usr/bin/bash

source /home/alarm/Documents/phone/bash-scripts/config.sh


while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/alarm/Documents/latex/20-21/ 

do

rsync -av --delete  --rsh='ssh -p8022' --exclude '.git/*' /home/alarm/Documents/latex/20-21/ $user_cp@$ip_cp:/storage/4A3C-18EA/Android/data/com.termux/files/Documents/documents/latex/20-21 &&


notify-send "Uploaded tex files!"

done









