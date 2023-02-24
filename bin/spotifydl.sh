#!/bin/bash

#Check if spotdl module is installed or not
if ! command -v spotdl &> /dev/null
then
    echo "spotdl is not installed. "
    
    # Prompt to install spotdl
    echo "Do you want to install spotdl? "
    read ans
    if [[ "$ans" == "yes" ]];then
        pip3 install spotdl
        echo "spotdl sucessfully installed!"
    else
        exit 127
    fi
fi

#condition of checking if ffmpeg is installed or not
if ! command -v ffmpeg &> /dev/null
then
    echo "ffmpeg is not installed. "
    
    # Prompt to install ffmpeg
    echo "Do you want to install ffmpeg? "
    read ans
    if [[ "$ans" == "yes" ]];then
        sudo apt install ffmpeg
        echo "ffmpeg sucessfully installed!"
    else
        exit 127
    fi
fi

#Implement a condition to choose between songs/playlist/album
echo "Specify your choice :
    Press 1 for downloading a song
    Press 2 for downloading a playlist
    Press 3 for downloading an album"
read arg

if [[ "$arg" == "1" ]];then
    echo "You have selected to download song"
    arg="song"

    echo "Enter the $arg url you want to download : "
    read url
    spotdl --$arg $url -f "$(pwd)/Downloads/{artist} - {track-name}.{output-ext}"

elif [[ "$arg" == "2" ]];then
    echo "You have selected to download playlist"
    arg="playlist"

    echo "Enter the $arg url you want to download : "
    read url
    spotdl --$arg $url --write-to temp.txt
    spotdl --list=temp.txt -f "$(pwd)/Downloads/{artist} - {track-name}.{output-ext}"

elif [[ "$arg" == "3" ]];then
    echo "You have selected to download album"
    arg="album"
    
    echo "Enter the $arg url you want to download : "
    read url
    spotdl --$arg $url --write-to temp.txt
    spotdl --list=temp.txt -f "$(pwd)/Downloads/{artist} - {track-name}.{output-ext}"
else
    echo "Invalid Selection"
    exit 127
fi

