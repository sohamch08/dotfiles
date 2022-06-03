#!/bin/bash


name=$(date +"%d-%m-%y-%T")
file_name=$name.png



maim --select "/home/$USER/Pictures/$filename"

xclip -selection clipboard -target image/png -i ~/Pictures/$file_name