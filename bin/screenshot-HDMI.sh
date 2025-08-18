#!/bin/bash


name=$(date '+%Y-%m-%d-%H-%M-%S')
file_name="$name.png"


scrot "$HOME/Pictures/$file_name" -a 1920,0,1920,1080

xclip -selection clipboard -target image/png -i ~/Pictures/${file_name} &&
    notify-send "Screenshot taken ${file_name}" -i "$HOME/Pictures/$file_name"
