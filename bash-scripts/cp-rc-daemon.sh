#!/bin/sh

while inotifywait -e modify,attrib,close_write ~/Documents/phone/configs/rc.conf

do

cp ~/Documents/phone/configs/rc.conf ~/.config/ranger/rc.conf &&

notify-send "Copied rc.conf"

done
