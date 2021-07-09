#!/usr/bin/bash

source /home/alarm/Documents/phone/bash-scripts/config.sh

while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/alarm/Documents/laptop/
do

rsync -av --delete  --rsh='ssh -p8022' --exclude-from=/home/alarm/Documents/laptop/myscripts/bash-scripts/exclude-files.txt /home/alarm/Documents/laptop/ $user_cp@$ip_cp:/storage/4A3C-18EA/Android/data/com.termux/files/Document &&

#rsync -av --delete  --rsh='ssh -p8022' --exclude 'grade8-repository/master/.git/*' --exclude 'grade8-repository/assets/Grade8Lessons/.git/*' --exclude 'grade8-repository/calendar/Grade8Lessons/.git/*' --exclude 'myscripts/python-scripts/ExamAutoChecker/.git/*' --exclude 'myscripts/python-scripts/ExamAutoCheckerAssets/ExamAutoChecker/.git/*' --exclude 'myscripts/.git' /home/jonathan/Documents/ $user_cp@$ip_cp:/storage/4A3C-18EA/Android/data/com.termux/files/Document &&

notify-send "Uploaded docs!"

done
