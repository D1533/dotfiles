#!/bin/bash

# Get default route interface with lowest metric
IF=$(ip route | awk '/^default/ {print $5, $7}' | sort -k2n | head -n1 | awk '{print $1}')

# Get IPv4 address
IP=$(ip -4 addr show "$IF" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Exit if no interface
[ -z "$IF" ] && exit 0

if [ -n "$IP" ]; then
    echo "E: $IP "
    echo ""
else
    echo "E: down"
    echo ""
    echo "#bf616a"
fi

