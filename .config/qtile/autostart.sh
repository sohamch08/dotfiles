#!/bin/sh
# starts nitrogen to set wallpaper
nitrogen --restore &
# starts Network Manager
nm-applet &
# starts Bluetooth Manager
blueman-applet &

