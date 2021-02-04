#!/bin/sh

sudo chown /dev/mmcblk0

sudo mkdir /mnt/sdcard

sudo mount /dev/mmcblk0p1 /mnt/sdcard

sudo mkdir -p /mnt/sdcard/Documents 

sudo mkdir -p /mnt/sdcard/Downloads

rm -r ~/Documents

rm -r ~/Downloads

ln -s /mnt/sdcard/Documents ~/Documents

ln -s /mnt/sdcard/Downloads ~/Downloads


