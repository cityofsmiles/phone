#!/bin/sh

bat="$(cat /sys/class/power_supply/axp20x-battery/capacity)"

notify-send $bat