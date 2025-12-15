#!/bin/bash
VOL=$(amixer get Master | awk -F'[][]' 'END{print $2+0}')
MUTED=$(amixer get Master | grep -o '\[off\]')

if [ "$MUTED" = "[off]" ]; then
    echo "Vol muted"
    echo ""
    echo ""
    echo "#bf616a"
else
    [ $VOL -gt 100 ] && VOL=100
    echo " Vol $VOL% "
    echo ""
    echo ""
    echo "#a3be8c"
fi

