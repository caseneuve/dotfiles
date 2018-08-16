#!/bin/bash

# Last update: 16.08.18, 16:46:13 @x200

CASTDIR=$HOME/wid/cast
[[ -d $CASTDIR ]] || mkdir -p $CASTDIR

if [ "$1" = '--help' ];then
    echo 'usage: ~/dotfiles/bin/screencast.sh [filename]'
else
    dimensions=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}')
    if [ -n "$1" ]; then
        outFile="$CASTDIR/$1.mkv"
    else
        outFile="$CASTDIR/out.mkv"
    fi
    pkill compton;
    notify-send "screencast" "start in 3 sec."
    sleep 1 && xdotool key ctrl+space 
    notify-send "screencast" "start in 2 sec."
    sleep 1 && xdotool key ctrl+space
    notify-send "screencast" "start in 1 sec."
    sleep 1 && xdotool key ctrl+space
    ffmpeg -f x11grab -s "$dimensions" -i :0.0 "$outFile"
    compton &
fi

#[[ $(ps aux | grep compton | grep -v grep) ]] || compton &

