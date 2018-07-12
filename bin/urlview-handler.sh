#!/bin/bash

# Path:        ~/.bin/urlview-handler.sh
# Created:     04.04.18, 11:48    @x200
# Last update: 12.07.18, 15:42:02 @x200

# Doc: via Luke Smith github
# note: replacing feh with sxiv

ext="${1##*.}"
mpvFiles="mkv mp4 avi mov wmv flv"
fehFiles="png jpg jpeg jpe gif"
wgetFiles="mp3 mp3?source=feed pdf"
em="email"
mpvscript=~/bin/queuempv

if echo $fehFiles | grep -w $ext > /dev/null; then
    #nohup feh -. -B -- "$1" >/dev/null &
    sxiv -a -- "$1" > /dev/nul &
elif echo $mpvFiles | grep -w $ext > /dev/null; then
    [[ -f $mpvscript ]] && nohup $mpvscript "$1" >/dev/null || nohup mpv --loop --quiet "$1" > /dev/null &
elif echo $wgetFiles | grep -w $ext > /dev/null; then
    nohup wget "$1" >/dev/null &
elif echo $1 | grep "youtube\." > /dev/null; then
    [[ -f $mpvscript ]] && nohup ~/bin/queuempv "$1" >/dev/null || nohup mpv "$1" > /dev/null &
elif echo $1 | grep youtu.be > /dev/null; then
    nohup mpv "$1" > /dev/null &
elif echo $1 | grep vimeo > /dev/null; then
    nohup mpv "$1" > /dev/null &
else
    #nohup qutebrowser --target window "$1" >/dev/null &
    nohup qutebrowser "$1" >/dev/null &
fi

