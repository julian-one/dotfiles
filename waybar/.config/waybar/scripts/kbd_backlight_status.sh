#!/bin/bash

# Get current keyboard backlight percentage
percent=$(brightnessctl -d kbd_backlight -m | cut -d',' -f4 | tr -d '%')

# Ensure percent is a valid number
if [[ -z "$percent" ]] || [[ ! "$percent" =~ ^[0-9]+$ ]]; then
    percent="0"
fi

# Convert percentage to icon
if [[ "$percent" == "0" ]]; then
    icon="󰌌"
else
    icon="󰌐"
fi

# Output the icon and percentage
echo "$icon $percent%"