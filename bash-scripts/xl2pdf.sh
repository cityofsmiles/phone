#!/usr/bin/bash

in="$1"

soffice --headless --convert-to pdf:calc_pdf_Export "$in"
  
echo "Done!"