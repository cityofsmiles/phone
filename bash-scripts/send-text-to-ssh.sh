#!/usr/bin/bash

# bash /storage/emulated/0/GNURoot/home/Scripts/termux/send-text-to-ssh.sh "fuck"

user="jonathan"
ip='192.168.1.16'
port='22'

str="$1"

touch ~/.tmp 

echo $str > ~/.tmp

cat ~/.tmp | ssh -p $port $user@$ip "cat > ~/.tmp"


