#!/bin/bash

# Handle mouse scroll or direct adjustment
case "$1" in
    up)
        # Increase brightness by 5%
        brightnessctl set +5%
        ;;
    down)
        # Decrease brightness by 5%
        brightnessctl set 5%-
        ;;
    "")
        # No argument: show rofi input for direct value entry
        current=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')
        input=$(rofi -dmenu -theme minimal -p "Brightness (1-100):" -mesg "Current: ${current}%")

        # Validate and set brightness if input is provided
        if [[ -n "$input" ]] && [[ "$input" =~ ^[0-9]+$ ]] && [[ "$input" -ge 1 ]] && [[ "$input" -le 100 ]]; then
            brightnessctl set "${input}%"
        fi
        ;;
    *)
        # Direct percentage value
        if [[ "$1" =~ ^[0-9]+$ ]] && [[ "$1" -ge 1 ]] && [[ "$1" -le 100 ]]; then
            brightnessctl set "$1%"
        fi
        ;;
esac