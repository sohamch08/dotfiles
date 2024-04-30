#!/bin/bash

# Check if screen 2 is available on HDMI-A-0

# Define the HDMI port
HDMI_PORT="HDMI-A-0"

# Run xrandr to get information about available outputs
output=$(xrandr | grep -swc connected)
# Check if HDMI-A-0 is connected and active
if [[ $output = 2 ]]; then
    xrandr --output HDMI-A-0 --brightness 0.63
fi

