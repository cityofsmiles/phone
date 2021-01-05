#!/usr/bin/env python


import os
import sys
from wand.image import Image
from PyPDF2 import PdfFileReader
import argparse

status=0

def parseArguments():
    # Create argument parser
    parser = argparse.ArgumentParser()

    # Positional mandatory arguments
    parser.add_argument("inputPdf", help="Filename of the input PDF.", type=str)

    # Optional arguments
    parser.add_argument("-o", "--output", help="Output filename. Must be jpeg.", type=str, default='')

    # Print version
    parser.add_argument("-v", "--version", action="version", version='%(prog)s - Version 1.0')

    # Parse arguments
    args = parser.parse_args()
    return args


def try_file(inputfile):
    try:
        f = open(inputfile)
    except FileNotFoundError:
        print("File not found. Exiting.")
        sys.exit(1)

                
def pdf_to_jpeg(inputfile, outputfile):
    if outputfile == '': 
        output_filename = os.path.splitext(os.path.basename(inputfile))[0]
    else: 
        output_filename = os.path.splitext(os.path.basename(outputfile))[0]
    jpeg_dir = output_filename
    try:
        os.mkdir(jpeg_dir)
        print("Directory", jpeg_dir, "created.") 
    except FileExistsError:
        print("Directory", jpeg_dir, "already exists.")
    print("Converting pdf file to jpeg.")
    cur_dir = os.getcwd()
    output_path = os.path.join(cur_dir, jpeg_dir) 
    all_pages = Image(filename=inputfile, resolution=600)
    for i, page in enumerate(all_pages.sequence):
        with Image(page) as img:
            img.format = 'jpeg'            
            image_filename = '{}-{}.jpeg'.format(output_filename, i)
            print("Created", image_filename)
            image_filename = os.path.join(output_path, image_filename)
            img.save(filename=image_filename)
    print("Done!")
    print("The jpeg files are in the folder", jpeg_dir)
     


if __name__ == '__main__':
    args = parseArguments()
    try_file(args.inputPdf)
    pdf_to_jpeg(args.inputPdf, args.output) 
  
    
    
    
