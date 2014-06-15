#!/bin/bash

echo "please press any key in 10S"
xset dpms force off
sleep 10

echo "try to set 800x600"
 xrandr -s 8
sleep 10
echo "try to set 1680x1050"
xrandr -s 2
sleep 10
echo "try to set 1440x900"
xrandr -s 4

sleep 10 
echo "try to set 1280x1024"
xrandr -s 3
sleep 10
echo "try to set 1024x768"
 xrandr -s 6
sleep 10
echo "try to set 1920x1080"
 xrandr -s 0
sleep 10

echo "try to S3"

 rtcwake -m mem  -s 120

sleep 5

echo "try to S4"
 rtcwake -m disk -s 120

sleep 5

echo "try to set left"

xrandr -o left

		sleep 3
echo "try to set right"
xrandr -o right

		sleep 3
echo "try to set inverted "
xrandr -o inverted

		sleep 3
echo "try to set normal"
xrandr -o normal

		sleep 3

