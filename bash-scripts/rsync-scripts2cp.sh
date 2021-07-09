#!/usr/bin/bash

source /home/alarm/Documents/phone/bash-scripts/config.sh


while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/alarm/Documents/phone/ 

do

rsync -av --delete  --rsh='ssh -p8022' --exclude '.git/*' /home/alarm/Documents/phone/ $user_cp@$ip_cp:/storage/4A3C-18EA/Android/data/com.termux/files/Documents/documents/pinephone-scripts/ &&


notify-send "Uploaded scripts!"

done









