#!/bin/sh

while inotifywait -e modify,attrib,close_write /mnt/sdcard/Documents/phone/bash-scripts/config.sh

do

notify-send "Copied rc.conf"
echo "fuc"

done
