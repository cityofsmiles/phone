#!/usr/bin/sh

mkdir /home/alarm/Downloads/croc
cd /home/alarm/Downloads/croc

croc --yes --overwrite jobacsbakulawcityofsmiles87 && notify-send "File received."
