#!/bin/bash


# Get mic capture status
STATE=$(amixer -D pulse get Capture | awk -F'[][]' '/Front Left:/ {print $2; exit}')

# Output for i3blocks
if [ "$STATE" == "off" ]; then
    echo " Mic muted "
    echo
    echo "#F9E79F"
else
    echo " Mic on "
    echo
    echo "#a3be8c"
fi
