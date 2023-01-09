#!/bin/bash
# @ Valentin Urcun
# Script that show an icon when potentially annoying things are enabled : capslock, microphone and jack headset


# "on" if a jack cable is connected, off if not
headset=$(amixer -c 0 contents | awk -F"," '
$1 == "numid=20" {
	c=1
} c && /: values/ {
	split($0, a, "=") 
	print a[2];
	exit
}')

# "" if capslock enabled
capslock=$(xset q | grep "Caps Lock:   on")


if [ "$headset" = "on"  ]
then
	iconHeadset= 
fi

if [ "$capslock" != "" ]
then
	iconCaps= 
fi

# spaecethetic
if [ "$capslock" != "" ] && [ "$headset" = "on" ]
then
	spaceone=" "
fi


# icons output
echo "${iconCaps}$spaceone${iconHeadset}"


batcond=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state|to full|to empty|percentage")
batper=$(echo $a | cut -d " " -f 4)
batstate=$(echo $a | cut -d " " -f 2)

if [ "$batper" = "98%"] && [ "$batstate" = "charging" ]
then
    notify-send "Battery is full !!REMOVE CHARGER!!" -t 5000
fi

if [ "$batper" = "20%" ] && [ "$batstate" = "discharging" ]
then
    notify-send "Battery is low !!CONNECT THE CHARGER!!" -t 5000
fi

