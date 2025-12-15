#!/bin/bash

# Total memory in KiB
TOTAL_KB=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
AVAIL_KB=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)

# Used memory = total - available
USED_KB=$((TOTAL_KB - AVAIL_KB))

# Convert to GiB
USED_GIB=$(awk "BEGIN {printf \"%.1f\", $USED_KB/1024/1024}")

# Output for i3blocks
echo " Mem ${USED_GIB} GiB "
echo ""
echo ""
echo "#a3be8c"

