#!/bin/bash

# Last update: 2019-04-19, 01:11:10 @toshiba
# Doc:          
# Requires:    i3move; ffmpeg
# Log:         25/08/2018, send signal 9 to i3blocks → i3screencast-indicator.sh
#              24/08/2018, update: grab only active screen
#              24/08/2018, bug: with kbd it grabs always primary screen

[[ -n $DISPLAY ]] || $DISPLAY=:0
CASTDIR=$HOME/wid/cast
[[ -d $CASTDIR ]] || mkdir -p $CASTDIR
#I3GET=$GOPATH/bin/i3getgo
I3GET=$HOME/go/bin/i3getgo
DIMS=$(xrandr | grep $($I3GET -O) | grep -o "[0-9]*x[0-9]*+[0-9]*+[0-9]*")
SCREEN_DIMS=${DIMS%%+[0-9]*}
SCREEN_POS=$(echo ${DIMS#$SCREEN_DIMS} | tr '\+' ' ')
SCR_X=$(echo $SCREEN_POS | awk '{print $1}')

if [ -n "$1" ]; then
    outFile="$CASTDIR/$1.mkv"
else
    outFile="$CASTDIR/out.mkv"
fi

for ((i=3; i>0; i--)); do
    notify-send "screencast" "start in $i sec."
    sleep 1 && xdotool key ctrl+space
done

pkill -RTMIN+9 i3blocks
ffmpeg -f x11grab -s "$SCREEN_DIMS" -i $DISPLAY.0+$SCR_X,$SCR_Y -vcodec libx264 -preset ultrafast -threads 0 "$outFile"

pkill screenkey
pkill -RTMIN+9 i3blocks
