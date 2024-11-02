#!/bin/bash

# Define the image to use for the lock screen
IMAGE_PATH=~/Pictures/Wallpaper/Grub/background-01.jpg

# Function to update the lock screen
update_lock_screen() {
    # Get current date and time
    DATE_TIME=$(date +"%Y-%m-%d %H:%M:%S")
    # Get battery percentage
    BATTERY_PERCENTAGE=$(cat /sys/class/power_supply/BAT0/capacity)

    # Create an overlay image with date, time, and battery percentage
    convert "$IMAGE_PATH" \
        -gravity North \
        -font DejaVu-Sans \
        -pointsize 48 \
        -fill white \
        -annotate +0+50 "$DATE_TIME" \
        -annotate +0+100 "Battery: $BATTERY_PERCENTAGE%" \
        /tmp/lockscreen.png
}

# Lock the screen
i3lock -i ~/Pictures/Wallpaper/Grub/background-01.jpg  --color=000000 --scale fit --ind-pos="x+86:y+1003" &

# Loop to continuously update the lock screen
while true; do
    update_lock_screen
    # Sleep for 5 seconds before updating again
    sleep 5
done

