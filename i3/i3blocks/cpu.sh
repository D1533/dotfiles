#!/bin/bash

# Read first line from /proc/stat
CPU=($(head -n1 /proc/stat))

# Total time = sum of all fields
TOTAL1=$((CPU[1]+CPU[2]+CPU[3]+CPU[4]+CPU[5]+CPU[6]+CPU[7]+CPU[8]))

# Idle time = idle + iowait
IDLE1=$((CPU[4]+CPU[5]))

# Wait a short interval
sleep 0.5

CPU=($(head -n1 /proc/stat))
TOTAL2=$((CPU[1]+CPU[2]+CPU[3]+CPU[4]+CPU[5]+CPU[6]+CPU[7]+CPU[8]))
IDLE2=$((CPU[4]+CPU[5]))

# Calculate usage percentage
DIFF_TOTAL=$((TOTAL2 - TOTAL1))
DIFF_IDLE=$((IDLE2 - IDLE1))
USAGE=$(( (100*(DIFF_TOTAL-DIFF_IDLE)/DIFF_TOTAL) ))

# Choose color
if [ "$USAGE" -ge 95 ]; then
    COLOR="#bf616a"
elif [ "$USAGE" -ge 50 ]; then
    COLOR="#ebcb8b"
else
    COLOR="#a3be8c"
fi

# Output
echo " CPU ${USAGE}% "
echo ""
echo ""
echo "$COLOR"

