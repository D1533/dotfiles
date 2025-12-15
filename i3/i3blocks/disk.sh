#!/bin/bash
USAGE=$(df -h / | awk 'NR==2 {print $5}')   # e.g., 45%
echo " Disk ${USAGE} "
echo ""
echo ""
echo "#a3be8c"

