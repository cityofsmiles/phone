#!/bin/sh

while inotifywait -e modify,attrib,close_write ~/Documents/phone/configs/pinephone-profile

do

cp ~/Documents/phone/configs/pinephone-profile ~/.profile &&

notify-send "Copied profile."

done
