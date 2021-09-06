#!/bin/sh

dir="$1"

magnetlink="$( xsel -b -o )"

if [ "$dir" = "hidden" ]; then
	transmission-daemon && transmission-remote -w "/mnt/sdcard/.h" -a "$magnetlink" && notify-send "Torrent added."
else
	transmission-daemon && transmission-remote -w "/home/jonathan/Downloads/Movies" -a "$magnetlink" && notify-send "Torrent added."
fi





