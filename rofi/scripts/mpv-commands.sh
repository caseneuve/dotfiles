#!/bin/bash

# Path:        ~/scr/mpv-commands.sh
# Created:     14.07.18, 22:09    @x200
# Last update: 14.07.18, 22:51:41 @x200

## Doc:
# TODO: get current position > notify send
# TODO: set position to go
# TODO: change mode from video to audio ???

SOC=/tmp/mpv
CLIP="$(xclip -o -selection clipboard)"
POSITION=`echo '{ "command": ["get_property_string", "time-pos"] }' | socat - $SOC 2>/dev/null | jq .data | xargs | cut -d'.' -f 1`
selected=$(echo -e "forward 30s\nrewind 30s\nnext\nprevious\npause toggle\nstop\nstream audio yank\nload video stream" | rofi -theme mytheme -dmenu -p "mpv action: ")

case "$selected" in
    'forward 30s') echo '{ "command": [ "seek", "30" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'rewind 30s') echo '{ "command": [ "seek", "-30" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    next) echo '{ "command": [ "playlist-next" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    previous) echo '{ "command": [ "playlist-prev" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'pause toggle') echo '{ "command": [ "cycle", "pause" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'stream audio yank') mpv --really-quiet --no-video --input-ipc-server=$SOC "$CLIP" > /dev/null & ;;
    stop) echo '{ "command": [ "stop" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'load video stream') [[ $POSITION ]] && echo '{ "command": [ "loadfile", "$CLIP", "append-play" ] }' | socat - $SOC 2>/dev/null || mpv "$CLIP" --input-ipc-server=$SOC > /dev/null &;;
    *) exit 0
esac

# echo '{ "command": [ "seek", "-30" ] }' | socat - $SOC 2>/dev/null
# echo '{ "command": [ "seek", "30" ] }' | socat - $SOC 2>/dev/null
# echo '{ "command": [ "playlist-next" ] }' | socat - $SOC 2>/dev/null
# echo '{ "command": [ "playlist-prev" ] }' | socat - $SOC 2>/dev/null

