#!/bin/bash

# Get current brightness percentage for display
current=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')

# Show rofi input with current brightness as placeholder
input=$(rofi -dmenu -theme minimal -p "Brightness (1-100):" -mesg "Current: ${current}%")

# Validate and set brightness if input is provided
if [[ -n "$input" ]] && [[ "$input" =~ ^[0-9]+$ ]] && [[ "$input" -ge 1 ]] && [[ "$input" -le 100 ]]; then
    brightnessctl set "${input}%"
fi
