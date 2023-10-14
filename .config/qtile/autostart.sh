#!/bin/sh
# starts nitrogen to set wallpaper
nitrogen --restore &
# starts Network Manager
nm-applet &
# starts Bluetooth Manager
blueman-applet &
# Set brightness
brightnessctl -d amdgpu_bl1 set 30 &
# Charging notification
/home/sohamch/bin/chargingnotify.sh &
# Battery status notification
/home/sohamch/bin/batterynotify.sh &
# Switches power profile to battery saving
system76-power profile battery &
