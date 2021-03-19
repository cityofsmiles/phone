#!/bin/sh

sudo cp /home/alarm/Documents/phone/bash-scripts/mount-sd.service /etc/systemd/system/

sudo cp /home/alarm/Documents/phone/bash-scripts/mount-sd /usr/bin/

sudo chmod 755 /usr/bin/mount-sd

sudo systemctl enable mount-sd.service

sudo systemctl start mount-sd.service
