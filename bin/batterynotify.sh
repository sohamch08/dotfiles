#!/bin/bash

while true; do
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')

    if [[ $battery_level -le 15 ]]; then
        dunstify -u critical "Low Battery" "Battery level is ${battery_level}%" -i "/home/sohamch/.config/dunst/icons/battery-alert.png"
    elif [[ $battery_level -ge 95 ]]; then
        dunstify -u normal "Full Battery" "Battery level is ${battery_level}%" -i "/home/sohamch/.config/dunst/icons/battery-alert-variant.png"
    fi

    sleep 300  # Check every 2 minutes (adjust as needed)
done
