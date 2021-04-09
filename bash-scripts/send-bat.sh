#! /bin/sh

cat /sys/class/power_supply/axp20x-battery/capacity | telegram-send --stdin
