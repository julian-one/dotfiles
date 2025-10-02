#!/bin/bash
UPTIME_PRETTY=$(uptime -p)

UPTIME_FORMATTED=$(echo "$UPTIME_PRETTY" | sed 's/^up //;s/, / /g;s/ minutes\?/m/g;s/ hours\?/h/g;s/ days\?/d/g;s/ weeks\?/w/g')

echo " $UPTIME_FORMATTED"
