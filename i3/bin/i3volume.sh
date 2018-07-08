#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/i3volume.sh
# Created:     08.07.18, 22:34    @x200
# Last update: 08.07.18, 22:40:50 @x200

# Doc: i3blocks volume script

vol=`amixer | grep "^\s*Front Left" | awk 'NR==1 {print $(NF-1)}' | sed 's/\[\|\]//g'`
state=`amixer | grep "^\s*Front Left" | awk 'NR==1 {print $(NF)}' | sed 's/\[\|\]//g'`

if [ "$state" = "on" ]; then
    echo $vol
else
    echo "MUTE"
fi

case $BLOCK_BUTTON in
    #1 = Left, 2 = Middle, 3 = Right, 4 = Scroll Up, 5 = Scroll Down
    4) pactl set-sink-volume 0 +5%  && pkill -RTMIN+1 i3blocks;;
    5) pactl set-sink-volume 0 -5%  && pkill -RTMIN+1 i3blocks;;
esac


