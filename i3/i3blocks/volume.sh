#!/bin/bash

# Get the line containing the volume and mute info for Master
LINE=$(amixer get Master | grep -E -o 'Front Left:.*' | tail -n1)

# Extract volume (number before %)
VOL=$(echo "$LINE" | awk -F'[][]' '{print $2+0}')

# Extract mute status (on/off)
MUTED=$(echo "$LINE" | awk -F'[][]' '{print $4}')

if [ "$MUTED" = "off" ]; then
    echo " Vol muted "
    echo ""
    echo "#F9E79F"
else
    [ $VOL -gt 100 ] && VOL=100
    echo " Vol $VOL% "
    echo ""
    echo "#a3be8c"
fi

