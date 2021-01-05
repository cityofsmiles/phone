#!/usr/bin/bash

# bash /storage/emulated/0/GNURoot/home/Scripts/termux/send-text-to-ssh.sh "fuck"

source /home/jonathan/Documents/myscripts/bash-scripts/config.sh

str="$1"

touch ~/.tmp 

echo $str > ~/.tmp

cat ~/.tmp | ssh -p $port_cp $user_cp@$ip_cp "cat > /storage/emulated/0/GNURoot/home/Scripts/termux/to-clipboard.txt"


