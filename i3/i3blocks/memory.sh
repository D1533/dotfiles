#!/bin/bash

# Total memory in KiB
TOTAL_KB=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
AVAIL_KB=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)

# Used memory = total - available
USED_KB=$((TOTAL_KB - AVAIL_KB))

# Convert to GiB
USED_GIB=$(awk "BEGIN {printf \"%.1f\", $USED_KB/1024/1024}")

# Determine color based on used memory
if (( $(echo "$USED_GIB >= 0 && $USED_GIB < 5" | bc -l) )); then
    COLOR="#a3be8c"  # green
elif (( $(echo "$USED_GIB >= 5 && $USED_GIB < 10" | bc -l) )); then
    COLOR="#ebcb8b"  # yellow
else
    COLOR="#bf616a"  # red
fi

# Output for i3blocks
echo " Mem ${USED_GIB} GiB "
echo ""
echo "#a3be8c"

