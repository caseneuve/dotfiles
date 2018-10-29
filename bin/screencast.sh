#!/bin/bash

# Last update: 29.10.18, 20:27:25 @lenovo

# >> DOC:
# requires i3move (i3ipc installed via pip)

# >> LOG: 
# 25/08/2018 send signal 9 to i3blocks → i3screencast-indicator.sh
# 24/08/2018 update: grab only active screen (todo: check how does it work with one screen)
# 24/08/2018: bug: with kbd it grabs always primary screen (why?)

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
# if [[ $(pgrep grep compton) ]]; then
#     pkill compton;
#     COM=1
# fi
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
pkill -RTMIN+9 i3blocks
ffmpeg -f x11grab -s "$SCREEN_DIMS" -i :0.0+$SCR_X,$SCR_Y "$outFile"
# 4.
# [ $COM == 1 ] && compton &
pkill -RTMIN+9 i3blocks
