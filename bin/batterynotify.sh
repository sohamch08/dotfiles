#!/bin/bash

while true; do
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')

    if [[ $battery_level -le 30 ]]; then
        dunstify -u critical 'Low Battery'$'\n''Battery level is '$battery_level'%' -i "/home/sohamch/.config/dunst/icons/battery-alert.png"
    elif [[ $battery_level -ge 80 ]]; then
        dunstify -u low 'Full Battery'$'\n''Battery level is '$battery_level'%' -i "/home/sohamch/.config/dunst/icons/battery-alert-variant.png"
    fi

    sleep 300  # Check every 2 minutes (adjust as needed)
done
