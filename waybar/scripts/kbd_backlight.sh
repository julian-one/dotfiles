#!/bin/bash
case "$1" in
    up) brightnessctl -d kbd_backlight set +10% ;;
    down) brightnessctl -d kbd_backlight set 10%- ;;
    toggle)
        [[ $(brightnessctl -d kbd_backlight -m | cut -d',' -f4 | tr -d '%') == "0" ]] \
            && brightnessctl -d kbd_backlight set 50% \
            || brightnessctl -d kbd_backlight set 0
        ;;
    status)
        p=$(brightnessctl -d kbd_backlight -m 2>/dev/null | cut -d',' -f4 | tr -d '%')
        [[ "$p" =~ ^[0-9]+$ ]] || p=0
        echo "$([[ "$p" != "0" ]] && echo "󰌌" || echo "󰌐") $p%"
        ;;
    *)
        current=$(brightnessctl -d kbd_backlight -m | cut -d',' -f4 | tr -d '%')
        input=$(rofi -dmenu -theme minimal -p "Keyboard Light (0-100):" -mesg "Current: ${current}%")
        [[ "$input" =~ ^[0-9]+$ ]] && [[ "$input" -ge 0 ]] && [[ "$input" -le 100 ]] && brightnessctl -d kbd_backlight set "${input}%"
        ;;
esac
