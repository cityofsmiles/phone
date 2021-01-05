#!/usr/bin/env python
# coding: utf-8



import PySimpleGUI as sg      
import os
import subprocess

layout = [[sg.Text('Enter abbreviation.')],      
                 [sg.InputText()], [sg.Text('Enter full text.')],      
                 [sg.InputText()],      
                 [sg.Submit(), sg.Cancel()]]      

window = sg.Window('New Entry for Texpander', layout)    

event, values = window.read()    
window.close()

abbr = values[0]
fulltext = values[1]

os.chdir("/home/jonathan/Documents/myscripts/bash-scripts/")

subprocess.call(["./newmatch.sh", "%s" % abbr, "%s" % fulltext])



