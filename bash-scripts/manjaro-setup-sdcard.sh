#!/bin/sh

source ./config.sh

#sudo mkdir /mnt/sdcard

#sudo mount /dev/mmcblk0p1 /mnt/sdcard

#sudo mkdir -p /mnt/sdcard/Documents 

#sudo mkdir -p /mnt/sdcard/Downloads

#sudo chown -R $user_pine /mnt/sdcard

sudo mkdir -p /media/mmcblk0p1/Documents 

sudo mkdir -p /media/mmcblk0p1/Downloads

sudo chown -R $user_pine /media/mmcblk0p1

rm -r ~/Documents

rm -r ~/Downloads

ln -s /media/mmcblk0p1/Documents ~/Documents

ln -s /media/mmcblk0p1/Downloads ~/Downloads

#ln -s /mnt/sdcard/Documents ~/Documents

#ln -s /mnt/sdcard/Downloads ~/Downloads

echo 'Copying phone to sdcard'

cp -r ~/phone ~/Documents
