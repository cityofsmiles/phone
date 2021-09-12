#!/usr/bin/sh


in="$( ls *.pdf )"

start=$(($1-1))
end=$(($2-1))

#start="$1"
#end="$2"
dir="$3"

mkdir $dir

out="${in%.*}"

convert -verbose -density 300 $out.pdf[$start-$end] -quality 50 ./$dir/$dir%02d.png