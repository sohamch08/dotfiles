#!/bin/bash

# Define the image to use for the lock screen
IMAGE_PATH=~/Pictures/Wallpaper/Grub/background-01.png

# Lock the screen with the image and move the ring to the specified position
i3lock -i "$IMAGE_PATH" --color=000000 --scale fit  --inside-position="x+20:y+H-20" --ring-position="x+20:y+H-20"
