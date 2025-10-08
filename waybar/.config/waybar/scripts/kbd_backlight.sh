#!/bin/bash

# Handle mouse scroll or direct adjustment for keyboard backlight
case "$1" in
    up)
        # Increase keyboard backlight by 10%
        brightnessctl -d kbd_backlight set +10%
        ;;
    down)
        # Decrease keyboard backlight by 10%
        brightnessctl -d kbd_backlight set 10%-
        ;;
    toggle)
        # Toggle between 0 and 50%
        current=$(brightnessctl -d kbd_backlight -m | cut -d',' -f4 | tr -d '%')
        if [[ "$current" == "0" ]]; then
            brightnessctl -d kbd_backlight set 50%
        else
            brightnessctl -d kbd_backlight set 0
        fi
        ;;
    "")
        # No argument: show rofi input for direct value entry
        current=$(brightnessctl -d kbd_backlight -m | cut -d',' -f4 | tr -d '%')
        input=$(rofi -dmenu -theme minimal -p "Keyboard Light (0-100):" -mesg "Current: ${current}%")

        # Validate and set keyboard backlight if input is provided
        if [[ -n "$input" ]] && [[ "$input" =~ ^[0-9]+$ ]] && [[ "$input" -ge 0 ]] && [[ "$input" -le 100 ]]; then
            brightnessctl -d kbd_backlight set "${input}%"
        fi
        ;;
    *)
        # Direct percentage value
        if [[ "$1" =~ ^[0-9]+$ ]] && [[ "$1" -ge 0 ]] && [[ "$1" -le 100 ]]; then
            brightnessctl -d kbd_backlight set "$1%"
        fi
        ;;
esac