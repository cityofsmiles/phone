#!/bin/sh

sudo chown -R jonathan /dev/mmcblk0

sudo mkdir /mnt/sdcard

sudo mount /dev/mmcblk0p1 /mnt/sdcard

sudo chown -R jonathan /mnt/sdcard

sudo mkdir -p /mnt/sdcard/Documents 

sudo mkdir -p /mnt/sdcard/Downloads

#sudo mkdir -p /media/mmcblk0p1/Documents 

#sudo mkdir -p /media/mmcblk0p1/Downloads


rm -r ~/Documents

rm -r ~/Downloads

#ln -s /media/mmcblk0p1/Documents ~/Documents

#ln -s /media/mmcblk0p1/Downloads ~/Downloads

ln -s /mnt/sdcard/Documents ~/Documents

ln -s /mnt/sdcard/Downloads ~/Downloads

cp -r ~/phone ~/Documents
