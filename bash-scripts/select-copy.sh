#!/usr/bin/env sh
# scrot refuses to work with double quotes
# shellcheck disable=SC2016

#tmpdir=tmp
#tmpfile=tmp.txt

#mkdir $tmpdir
#cd $tmpdir

notify-send "Select area to copy" && scrot -e 'echo $f | xsel -i -b' -d 1 -s -q 1 

#rm $tmpfile
#
select=$(xsel -o -b)

tesseract $select tmp --dpi 200

cat tmp.txt | xsel -i -b

rm tmp.txt
rm $select

notify-send "Text copied"

