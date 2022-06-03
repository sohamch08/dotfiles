#!/bin/bash


name=$(date +"%d-%m-%y-%T")
file_name=$name.png


scrot ~/Pictures/$file_name

xclip -selection clipboard -target image/png -i ~/Pictures/$file_name