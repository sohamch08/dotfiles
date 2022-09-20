#!/bin/sh

Device_Name="${1}"
Current_State=$(xinput list-props "${Device_Name}" | grep -i 'Device Enabled' | sed 's/^.*\([0-1]\)$/\1/')

if [[ "${Current_State}" -eq "1" ]]; then
	xinput disable "${Device_Name}"
	notify-send -t 2000 'Xorg-input' "${Device_Name} off"
else
	xinput enable "${Device_Name}"
	notify-send -t 2000 'Xorg-input' "${Device_Name} on"
fi
