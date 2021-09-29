#!/bin/sh

case $1 in
  1) cal && read -r ;;
  2) cal -3 && read -r ;;
  *) cal && read -r ;;
esac
