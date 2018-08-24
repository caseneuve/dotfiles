#!/bin/bash

# Last update: 24.08.18, 11:31:25 @x200

# >> DOC:
# 24/08/2018 update: grab only active screen (todo: check how does it work with one screen)

# >> set output directory, if doesn't exist - create one:
CASTDIR=$HOME/wid/cast
[[ -d $CASTDIR ]] || mkdir -p $CASTDIR

# >> set ffmpeg parameters:
DIMS=$(xrandr | grep "$(i3move -i | rg Output | awk '{print $2}')" | grep -o "[0-9]*x[0-9]*+[0-9]*+[0-9]*")
SCREEN_DIMS=${DIMS%%+[0-9]*}
SCREEN_POS=$(echo ${DIMS#$SCREEN_DIMS} | tr '\+' ' ')
SCR_X=$(echo $SCREEN_POS | awk '{print $1}')
SCR_Y=$(echo $SCREEN_POS | awk '{print $2}')
# @old:
#dimensions=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}')

# >> set output file name:
if [ -n "$1" ]; then
    outFile="$CASTDIR/$1.mkv"
else
    outFile="$CASTDIR/out.mkv"
fi

# >> run
# 1. kill compton (to avoid glithes, todo: can we fix this?)
if [[ $(ps aux | grep compton | grep -v grep) ]]; then
    pkill compton;
    COM=1
fi
# 2. countdown:
notify-send "screencast" "start in 3 sec."
sleep 1 && xdotool key ctrl+space 
notify-send "screencast" "start in 2 sec."
sleep 1 && xdotool key ctrl+space
notify-send "screencast" "start in 1 sec."
sleep 1 && xdotool key ctrl+space
# 3. run ffmpeg
# @old:
#ffmpeg -f x11grab -s "$dimensions" -i :0.0 "$outFile"
ffmpeg -f x11grab -s "$SCREEN_DIMS" -i :0.0+$SCR_X,$SCR_Y "$outFile"
# 4.
[ $COM == 1 ] && compton &

