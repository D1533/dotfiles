#!/bin/bash

# Get default route interface with lowest metric
IF=$(ip route | awk '/^default/ {print $5, $7}' | sort -k2n | head -n1 | awk '{print $1}')

# Get IPv4 address
IP=$(ip -4 addr show "$IF" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [ -n "$IP" ]; then
    echo "E: $IP "
    echo ""
    echo ""
    echo "#a3be8c"   # green
else
    echo "E: down"
    echo ""
    echo ""
    echo "#bf616a"   # red
fi

