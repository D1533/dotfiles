#!/bin/bash
BAT_PATH="/sys/class/power_supply/BAT0"
STATUS=$(cat "$BAT_PATH/status")
CAPACITY=$(cat "$BAT_PATH/capacity")

if [ "$STATUS" = "Charging" ]; then
    COLOR="#a3be8c"   # green
    SYMBOL="CHR"
elif [ "$CAPACITY" -le 10 ]; then
    COLOR="#bf616a"   # red
    SYMBOL="BAT"
else
    COLOR="#ebcb8b"   # yellow
    SYMBOL="BAT"
fi

echo " $SYMBOL $CAPACITY% "
echo ""
echo ""
echo "$COLOR"

