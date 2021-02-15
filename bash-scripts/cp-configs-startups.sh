#!/bin/sh

#sudo cp -r ~/Documents/phone/pmos-startup-scripts/* /etc/local.d/

cp ~/Documents/phone/configs/pinephone-profile ~/.profile; 

cp ~/Documents/phone/configs/rc.conf ~/.config/ranger/rc.conf

sudo cp -r ~/Documents/phone/pmos-init-files/* /etc/init.d/

#cp ~/Documents/phone/configs/bashrc ~/.bashrc

cp ~/.purple/blist.xml ~/Documents/phone/configs/blist.xml

cp ~/.purple/accounts.xml ~/Documents/phone/configs/accounts.xml