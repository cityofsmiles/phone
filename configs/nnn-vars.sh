#!/usr/bin/sh
export VISUAL=mousepad
export EDITOR=mousepad
export NNN_PLUG='m:-!&mousepad $nnn*;n:-!sudo -E micro $nnn*;o:-!&mousepad;p:preview-tabbed'

export NNN_FIFO=/tmp/nnn.fifo
export NNN_BMS="d:$HOME/Documents;h:$HOME;s:/mnt/sdcard/Documents/phone;z:$HOME/Downloads/"
