#!/bin/bash

#* Last update: 2019-10-02, 10:03:35 @lenovo
#  Doc:         simple screencasting (grab only active screen) 
#  Requires:    i3getgo; ffmpeg

#* get current screen dimensions
[[ -n $DISPLAY ]] || DISPLAY=:0

CASTDIR=$HOME/wid/cast
[[ -d $CASTDIR ]] || mkdir -p $CASTDIR

I3GET=$HOME/go/bin/i3getgo

DIMS=$(xrandr | grep $($I3GET -O) | grep -o "[0-9]*x[0-9]*+[0-9]*+[0-9]*")
SCREEN_DIMS=${DIMS%%+[0-9]*}
SCREEN_POS=$(echo ${DIMS#$SCREEN_DIMS} | tr '\+' ' ')
SCR_X=$(echo $SCREEN_POS | awk '{print $1}')
SCR_Y=$(echo $SCREEN_POS | awk '{print $2}')

#* set output file
if [ -n "$1" ]; then
    outFile="$CASTDIR/$1.mkv"
else
    outFile="$CASTDIR/out$(date '+%d%h%H%M').mkv"
fi

#* begin countdown
for ((i=3; i>0; i--)); do
    notify-send "screencast" "start in $i sec. (press mod+ctrl+f12 to stop)"
    sleep 1 && xdotool key ctrl+space
done

#* set status bar info
POLY1=/tmp/polybar-ipc-primary
echo hook:module/cast2 >> $POLY1
# pkill -RTMIN+9 i3blocks

#* start recording
ffmpeg -f x11grab -s "$SCREEN_DIMS" -i $DISPLAY.0+$SCR_X,$SCR_Y -vcodec libx264 -preset ultrafast -threads 0 "$outFile"

#* cleanup
pkill screenkey
echo hook:module/cast1 >> $POLY1
# pkill -RTMIN+9 i3blocks

