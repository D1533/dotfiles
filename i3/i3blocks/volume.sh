#!/bin/bash

# Handle mouse clicks
case "$BLOCK_BUTTON" in
    1) amixer -q set Master 5%+ ;;
    3) amixer -q set Master 5%- ;;
    2) amixer -q set Master toggle ;;
esac

# Force instant refresh (must match signal in i3blocks config)
pkill -RTMIN+10 i3blocks 2>/dev/null

# Get last Front Left line
LINE=$(amixer get Master | grep -E 'Front Left' | tail -n1)

# Extract volume and mute
VOL=$(echo "$LINE" | awk -F'[][]' '{print $2+0}')
MUTED=$(echo "$LINE" | awk -F'[][]' '{print $4}')

# Clamp volume
[ $VOL -gt 100 ] && VOL=100

# Output for i3blocks
if [ "$MUTED" = "off" ]; then
    echo " Vol muted "
    echo
    echo "#F9E79F"
else
    echo " Vol $VOL% "
fi

