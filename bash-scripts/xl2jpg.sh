#!/usr/bin/bash

outdir="converted"

if [ -d $outdir ];then
    echo "Output folder exists."
else
    mkdir $outdir
fi

#in="$1"
#files="$(ls *.xlsx)"

for file in *.xlsx;
do
  out="${file%.*}";
  #echo $out;
  soffice --headless --convert-to pdf:calc_pdf_Export --outdir $outdir "$file"
  cd $outdir
  vips copy "$out".pdf[dpi=600,page=0,n=-1] "$out".jpeg
  rm "$out".pdf
  cd ..
done
#

#
#echo $in
echo "Done!"