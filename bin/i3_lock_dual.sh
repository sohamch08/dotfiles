#!/bin/bash

# Paths to your images
IMAGE_A="$HOME/Pictures/Wallpaper/Others/t9wisfy5awaa1.jpg"
IMAGE_B="$HOME/Pictures/Wallpaper/Others/o6lintmgye981.jpg"

# Get monitor resolutions
RESOLUTIONS=$(xrandr --listmonitors | awk 'NR > 1 && / / {print $4}')

# Set monitor resolutions
MONITOR_1_RESOLUTION="1920x1080"
MONITOR_2_RESOLUTION="1440x900"

# Check if monitor 1 is connected
if echo "$RESOLUTIONS" | grep -q "$MONITOR_1_RESOLUTION"; then
    MONITOR_1="$IMAGE_A"
else
    MONITOR_1="$IMAGE_B"
fi

# Check if monitor 2 is connected
if echo "$RESOLUTIONS" | grep -q "$MONITOR_2_RESOLUTION"; then
    MONITOR_2="$IMAGE_A"
else
    MONITOR_2="$IMAGE_B"
fi

# Lock the screen with different images for each monitor
i3lock -i "$MONITOR_1" -i "$MONITOR_2"

