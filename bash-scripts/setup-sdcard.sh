#!/bin/sh

sudo mount /dev/mmcblk0p1 /mnt/sdcard

mkdir -p /mnt/sdcard/Documents 

mkdir -p /mnt/sdcard/Downloads

rmdir ~/Documents

rmdir ~/Downloads

ln -s /mnt/sdcard/Documents ~/Documents

ln -s /mnt/sdcard/Downloads ~/Downloads


