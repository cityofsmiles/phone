#!/bin/sh

sudo chown /dev/mmcblk0

#sudo mkdir /mnt/sdcard

#sudo mount /dev/mmcblk0p1 /mnt/sdcard

sudo mkdir -p /media/mmcblk0p1/Documents 

sudo mkdir -p /media/mmcblk0p1/Downloads

rm -r ~/Documents

rm -r ~/Downloads

ln -s /media/mmcblk0p1/Documents ~/Documents

ln -s /media/mmcblk0p1/Downloads ~/Downloads


