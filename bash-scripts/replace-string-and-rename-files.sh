#!/bin/bash

# bash /home/jonathan/Documents/myscripts/replace-string-and-rename-files.sh

dir=$(pwd) 

str="$1"

replace="$2"

grep -rl $str $dir | xargs sed -i "s|$str|$replace|g"

cd $dir

rename.ul $str $replace *
