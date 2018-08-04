#!/bin/bash

# Last update: 03.08.18, 10:47:18 @x200

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
#    pkill compton;
    ffmpeg -f x11grab -s "$dimensions" -i :0.0 "$outFile"
fi

[[ $(ps aux | grep compton | grep -v grep) ]] || compton &

