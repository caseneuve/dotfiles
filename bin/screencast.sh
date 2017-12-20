#!/bin/bash

if [ ! -d "$HOME/Wideo/cast" ]; then
    mkdir $HOME/Wideo/cast
fi;

pkill compton;

if [ "$1" = '--help' ];then
    echo 'Usage ./screencast.sh [filename]'
else
    dimensions=`xdpyinfo | grep 'dimensions:'|awk '{print $2}'`
    if [ -n "$1" ];then
        outFile="$HOME/Wideo/cast/$1.mkv"
    else
        outFile="$HOME/Wideo/cast/out.mkv"
    fi
    ffmpeg -f x11grab -s "$dimensions" -i :0.0 "$outFile"
fi

compton
