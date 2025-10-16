#!/bin/bash
uptime -p | sed 's/^up //;s/, / /g;s/ \(minute\|hour\|day\|week\)s\?/\L\1/g;s/minute/m/;s/hour/h/;s/day/d/;s/week/w/'
