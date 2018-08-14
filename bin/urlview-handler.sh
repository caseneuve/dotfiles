#!/bin/bash

# Path:        ~/.bin/urlview-handler.sh
# Created:     04.04.18, 11:48    @x200
# Last update: 14.08.18, 15:04:24 @x200

# Doc: via Luke Smith github
# note: replacing feh with sxiv
# done: problem na współpracy z queuemv → argument sie nie rozwija, lecz cytuje się nazwa (należy cytuwać podwójnymi nawiasami)

ext="${1##*.}"
mpvFiles="mkv mp4 avi mov wmv flv"
fehFiles="png jpg jpeg jpe gif"
wgetFiles="mp3 mp3?source=feed pdf"
em="email"
mpvscript=~/.dotfiles/bin/queuempv

if echo $fehFiles | grep -w $ext > /dev/null; then
    nohup feh -. -B -- "$1" >/dev/null &
    # nohup sxiv -a -- "$1" > /dev/null & # sxiv nie potrafi otwierać linków
elif echo $mpvFiles | grep -w $ext > /dev/null; then
    [[ -f $mpvscript ]] && nohup $mpvscript "$1" >/dev/null || nohup mpv --loop --quiet "$1" > /dev/null &
elif echo $wgetFiles | grep -w $ext > /dev/null; then
    nohup wget "$1" >/dev/null &
elif echo $1 | grep "youtube\.\|youtu\.be" > /dev/null; then
    if [[ -f $mpvscript ]]; then
        nohup $mpvscript "$1" &
        #notify-send -u low "Urlview" "Video:\n\n<i>`curl -s $1 | grep -o \"<title>[^<]*\" | tail -c+8`</i>\n\nis loading."
    else
        nohup mpv "$1" > /dev/null &
    fi
# elif echo $1 | grep youtu.be > /dev/null; then
#      nohup mpv "$1" > /dev/null &
elif echo $1 | grep vimeo > /dev/null; then
    nohup mpv "$1" > /dev/null &
else
    #nohup qutebrowser --target window "$1" >/dev/null &
    nohup qutebrowser "$1" >/dev/null &
fi

