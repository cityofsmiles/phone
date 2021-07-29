#!/bin/sh

str="$1"
grep -rnw . -e "$str"