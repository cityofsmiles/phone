#!/usr/bin/bash

#file=$( ls *.tex )
file="$1"

name="${file%.*}"

#micro $file &
featherpad $file &

if [ -f $name.pdf ];then
    okular $name.pdf &
else
    notify-send "$name.pdf doesn't exist"
fi

while inotifywait -e modify,attrib,close_write,move,create,delete $file
do

pdflatex $file &&
notify-send "Pdf created"

done

