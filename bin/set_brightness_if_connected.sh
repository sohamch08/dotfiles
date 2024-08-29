#!/bin/bash

# Check if HDMI-A-0 is connected
if xrandr | grep "HDMI-A-0 connected"; then
    # Set the brightness
    xrandr --output HDMI-A-0 --brightness 0.80
fi
