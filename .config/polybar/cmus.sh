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
      #| zscroll -b "▶️"
  else echo " ${title}${artist}"
      #| zscroll -b "'"
  fi
fi
#!/bin/bash

# cmus=$(cmus-remote -Q | grep status)
# case "$cmus" in
# "status stop"*)
#     echo "No music!"
#     ;;
# "status paused"*)
#     echo "Song paused"
#     ;;
# 'status playing'*)
#     title=$(cmus-remote -Q | grep tag\ title\ )
#     print="${title:10}"
#
#     artist=$(cmus-remote -Q | grep tag\ artist\ )
#     print="${title:10} - ${artist:11}"
#
#     echo "$print"
#     ;;
# "")
#     echo "No music!"
#     ;;
# esac
