#!/bin/bash

title=$(playerctl metadata title)
artist=$(playerctl metadata artist)
echo "$title - $artist" > ~/.config/polybar/music_info.txt

# Send a signal to the Polybar module to reload and display the updated text
polybar-msg hook music 1

