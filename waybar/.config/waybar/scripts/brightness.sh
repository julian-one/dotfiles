#!/bin/bash
current=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')
input=$(rofi -dmenu -theme minimal -p "Brightness (1-100):" -mesg "Current: ${current}%")
[[ "$input" =~ ^[0-9]+$ ]] && [[ "$input" -ge 1 ]] && [[ "$input" -le 100 ]] && brightnessctl set "${input}%"
