#!/usr/bin/sh

cd /home/alarm/Documents/laptop/grade8-repository/assets/Grade8Lessons
	git add --all
	git commit -m "$1"
	git push -u origin assets

mousepad /home/alarm/Documents/laptop/grade8-repository/master/README.md &&

cd /home/alarm/Documents/laptop/grade8-repository/master
	git add --all
	git commit -m "$1"
	git push -u origin main

