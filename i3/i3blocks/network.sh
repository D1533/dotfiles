#!/bin/bash

# Interval should be >= 1 in i3blocks config
INTERVAL=1

# Get default route interface with lowest metric
IF=$(ip route | awk '/^default/ {print $5, $7}' | sort -k2n | head -n1 | awk '{print $1}')

# Get IPv4 address
IP=$(ip -4 addr show "$IF" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Exit if no interface
[ -z "$IF" ] && exit 0

# Read byte counters
RX1=$(cat /sys/class/net/$IF/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$IF/statistics/tx_bytes)

sleep $INTERVAL

RX2=$(cat /sys/class/net/$IF/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$IF/statistics/tx_bytes)

# Calculate speed (bytes per second)
RX_RATE=$(( (RX2 - RX1) / INTERVAL ))
TX_RATE=$(( (TX2 - TX1) / INTERVAL ))

# Convert to human-readable
human() {
    awk -v b="$1" '
    function human(x) {
        s="BKMGT";
        while (x>=1024 && length(s)>1) {
            x/=1024; s=substr(s,2)
        }
        return sprintf("%.1f%s", x, substr(s,1,1))
    }
    BEGIN { print human(b) }
    '
}

RX_H=$(human "$RX_RATE")
TX_H=$(human "$TX_RATE")

if [ -n "$IP" ]; then
    echo "E: $IP ↓ $RX_H ↑ $TX_H"
    echo ""
else
    echo "E: down"
    echo ""
    echo "#bf616a"
fi

