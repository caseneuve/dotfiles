#!/bin/bash

# Path:        ~/.bin/urlview-handler.sh
# Created:     04.04.18, 11:48    @x200
# Last update: 30.06.18, 09:53:33 @x200

# Doc: via Luke Smith github

ext="${1##*.}"
mpvFiles="mkv mp4 avi mov wmv flv gif"
fehFiles="png jpg jpeg jpe"
wgetFiles="mp3 mp3?source=feed pdf"
em="email"

if echo $fehFiles | grep -w $ext > /dev/null; then
	nohup feh -. -B -- "$1" >/dev/null &
elif echo $mpvFiles | grep -w $ext > /dev/null; then
	nohup mpv --loop --quiet "$1" > /dev/null &
elif echo $wgetFiles | grep -w $ext > /dev/null; then
	nohup wget "$1" >/dev/null &
elif echo $1 | grep "youtube\." > /dev/null; then
    # that should deal with a bug: in urlview/mutt rendering YT links
        # var="${1//3D/}"
        # var="${var%=}"
    # nohup mpv "$var$em" > /dev/null &
    nohup mpv "$1" > /dev/null &
elif echo $1 | grep youtu.be > /dev/null; then
	nohup mpv "$1" > /dev/null &
elif echo $1 | grep vimeo > /dev/null; then
	nohup mpv "$1" > /dev/null &
else
    #nohup qutebrowser --target window "$1" >/dev/null &
    nohup qutebrowser "$1" >/dev/null &
fi

