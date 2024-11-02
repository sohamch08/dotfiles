#!/bin/bash

if [[ "$@" = "red" ]]; then
  echo Making screen red
  GAMMA=4:1.5:1
elif [[ "$@" = "blue" ]]; then
  echo Making screen blue
  GAMMA=1:1.5:3
elif [[ "$@" = "green" ]]; then
  echo Making screen green
  GAMMA=1:2:1
elif [[ "$@" = "night" ]]; then
  echo Making screen dim
  GAMMA="1:0.8:0.6 --brightness 0.6"
else
  echo Making screen normal
  GAMMA=1:1:1
fi

for output in $(xrandr --prop | grep \ connected | cut -d\  -f1); do
  xrandr --output $output --gamma $GAMMA
done
