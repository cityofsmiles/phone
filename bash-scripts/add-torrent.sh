#!/bin/sh

dir="$1"

magnetlink="$( xsel -b -o )"

transmission-daemon

if [ "$dir" = "hidden" ]; then
	transmission-remote -w "/mnt/sdcard/.h" -a "$magnetlink" && notify-send "Torrent added."
else
	transmission-remote -w "/home/jonathan/Downloads/Movies" -a "$magnetlink" && notify-send "Torrent added."
fi





