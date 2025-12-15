#!/bin/bash

# Get used and total space in KiB (use -B1K)
USAGE_KB=$(df --output=used / | tail -n1)

# Convert to GiB
USED_GIB=$(awk "BEGIN {printf \"%.1f\", $USAGE_KB/1024/1024}")


# i3blocks output: 3 lines (last line = color)
echo " Disk ${USED_GIB} GiB "

