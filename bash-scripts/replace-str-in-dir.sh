#!/bin/bash

# bash /home/jonathan/Documents/myscripts/replace-string-in-directory.sh 

dir=$(pwd)

str="$1"

replace="$2"

grep -rl $str $dir | xargs sed -i "s|$str|$replace|g"