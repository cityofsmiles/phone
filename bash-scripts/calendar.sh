#!/bin/sh

case $1 in
  1) cal && sleep 7s ;;
  2) cal -3 && sleep 10s ;;
  *) cal && sleep 7s ;;
esac
