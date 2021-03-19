#!/bin/sh

DIR="/mnt/sdcard"
if [ -d "$DIR" ]; then
  ### Take action if $DIR exists ###
  mount /dev/mmcblk0p1 /mnt/sdcard
else
  ###  Control will jump here if $DIR does NOT exists ###
  mkdir $DIR
  mount /dev/mmcblk0p1 /mnt/sdcard
fi



