#!/bin/bash

previous_status=""

while true; do
    charger_status=$(acpi -a | grep -o "on-line")

    if [[ $charger_status == "on-line" && $previous_status != "on-line" ]]; then
        dunstify -u normal "Charger Plugged In" "The charger has been plugged in." -t 2000
    elif [[ $charger_status != "on-line" && $previous_status == "on-line" ]]; then
        dunstify -u normal "Charger Unplugged" "The charger has been unplugged." -t 2000
    fi

    previous_status=$charger_status

    sleep 3  # Check every 5 seconds (adjust as needed)
done
