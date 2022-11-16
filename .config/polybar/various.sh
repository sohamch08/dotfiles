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

# "" if mic unmuted
mute=$(pactl list sources | grep  "Mute: yes")


if [ "$headset" = "on"  ]
then
	iconHeadset= 
fi

if [ "$capslock" != "" ]
then
	iconCaps= 
fi

if [ "$mute" = "" ]
then
	iconMute=
fi


# spaecethetic
if [ "$capslock" != "" ] && [ "$headset" = "on" ]
then
	spaceone=" "
fi

if ([ "$capslock" != "" ] && [ "$mute" = "" ]) || ([ "$headset" = "on" ] && [ "$mute" = "" ])
then
	spacetwo=" "
fi


# icons output
echo "${iconCaps}$spaceone${iconHeadset}$spacetwo${iconMute}"





