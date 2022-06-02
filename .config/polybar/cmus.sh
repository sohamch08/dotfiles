#!/bin/bash
ison=$(cmus-remote -Q | grep "set vol_right" | cut -c 15-)
title=$(cmus-remote -Q | grep "tag title" | cut -c 11-)
artist=$(cmus-remote -Q | grep "tag artist" | cut -c 12-)
if [ -z "$artist" ]
then artist=""
else artist=" - ﴁ $artist"
fi
playpause=$(cmus-remote -Q | grep "status" | cut -c 8-)
if [ $ison == 0 ]
then echo "No Music From Start"
else 
  if [ $playpause == "paused" ]
  then echo "▶️ ${title}${artist}"
  else echo " ${title}${artist}"
  fi
fi
