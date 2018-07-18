#!/bin/bash

# Path:        ~/scr/mpv-commands.sh
# Created:     14.07.18, 22:09    @x200
# Last update: 18.07.18, 13:31:11 @x200

## Doc:
# TODO: get current position > notify send
# TODO: set position to go
# TODO: change mode from video to audio ???

SOC=/tmp/mpv
CLIP="$(xclip -o -selection clipboard)"
POSITION=`echo '{ "command": ["get_property_string", "time-pos"] }' | socat - $SOC 2>/dev/null | jq .data | xargs | cut -d'.' -f 1`
selected=$(echo -e "forward 30s \nrewind 30s \nnext \nprevious \npause toggle \nstop \nstream audio yank \nload video stream \nshow playlist " | rofi -theme mytheme -dmenu -p "mpv action: ")

# show_list(){
#     TITLES=`mpv-socket -t`
#     COUNT=`echo "$TITLES" | wc -l`
#     for (( c=1; c<=$COUNT; c++ )); do
#         echo $COUNT
#         printf "%s" `mpv-socket -t`
#         echo `mpv-socket -t | awk 'NR==$c {print $0}'`
#         printf "%d. %s\n" $c $(echo "$TITLES" | awk 'NR==$c {print $0}')
#     done
# }

case "$selected" in
    'forward 30s ') echo '{ "command": [ "seek", "30" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'rewind 30s ') echo '{ "command": [ "seek", "-30" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'next ') echo '{ "command": [ "playlist-next" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'previous ') echo '{ "command": [ "playlist-prev" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'pause toggle ') echo '{ "command": [ "cycle", "pause" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
    'stream audio yank ') mpv --really-quiet --no-video --input-ipc-server=$SOC "$CLIP" > /dev/null & ;;
    'stop ') echo '{ "command": [ "stop" ] }' | socat - $SOC 2>/dev/null; pkill -RTMIN+4 i3blocks && exit 0 ;;
    'load video stream ') [[ $POSITION ]] && echo '{ "command": [ "loadfile", "$CLIP", "append-play" ] }' | socat - $SOC 2>/dev/null || mpv "$CLIP" --input-ipc-server=$SOC > /dev/null &;;
    'show playlist ') notify-send "MPV Playlist:
-------------" "`~/bin/mpv-socket -P`"
#"$(echo '{ "command": ["get_property", "playlist"] }' | socat - $SOC 2>/dev/null | jq .data[].filename | xargs)"
                      ;;
    # 'position') ~/scr/mpv-set-playlist-post.sh && exit 0 ;;
    *) exit 0;;
esac

# echo '{ "command": [ "seek", "-30" ] }' | socat - $SOC 2>/dev/null
# echo '{ "command": [ "seek", "30" ] }' | socat - $SOC 2>/dev/null
# echo '{ "command": [ "playlist-next" ] }' | socat - $SOC 2>/dev/null
# echo '{ "command": [ "playlist-prev" ] }' | socat - $SOC 2>/dev/null

