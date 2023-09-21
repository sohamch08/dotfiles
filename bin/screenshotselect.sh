#!/bin/bash


name=$(date '+%Y-%m-%d-%H:%M:%S')
file_name="$name.png"


maim -s -f png -o "$HOME/Pictures/$file_name"

xclip -selection clipboard -target image/png -i ~/Pictures/$file_name &&
    notify-send "Screenshot taken ${file_name}" -i "$HOME/Pictures/$file_name"
