#!/bin/bash

# Path:        ~/scr/mpv-commands.sh
# Created:     14.07.18, 22:09    @x200
# Last update: 25.07.18, 16:53:33 @x200

## Doc: MOCP & MPV controls for rofi
# TODO: get current position > notify send
# TODO: set position to go
# TODO: change mode from video to audio ???

# >> VARIABLES
CLIP="$(xclip -o -selection clipboard)"
MOC=$(mocp -i | awk 'NR==1 {print $2}')
MPV=$(mpv-socket -s)

# >> MPV FUNC
mpv_commands(){
    SOC=/tmp/mpv
    POSITION=$(echo '{ "command": ["get_property_string", "time-pos"] }' | socat - $SOC 2>/dev/null | jq .data | xargs | cut -d'.' -f 1)
    selected=$(echo -e "forward 30s \nrewind 30s \nnext \nprevious \npause toggle \nstop \nstream audio yank \nload video stream \nshow playlist " | rofi -theme mytheme -dmenu -p "mpv action: ")
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
}

# >> MOC FUNC
moc_commands(){
    selected=$(echo -e "[1] pause toggle\n[2] play (clip yank)\n[3] stop\n[4] previous\n[5] next\n[r] repeat (toggle)\n[q] enqueue (clip yank)\n[!] play (list)\n[>] forward 30 sec.\n[<] rewind 30 sec." | rofi -theme mytheme -dmenu -p "mocp action: ")
    case "$selected" in
        '[1] pause toggle') mocp -G ;;
        '[2] play (clip yank)') mocp -l "$CLIP" ;;
        '[3] stop') mocp -s ;;
        '[4] previous') mocp -r ;;
        '[5] next') mocp -f ;;
        '[r] repeat (toggle)') mocp -o r ;;
        '[q] enqueue (clip yank)') mocp -q "$CLIP" ;;
        '[!] play (list)') mocp -p;;
        '[>] forward 30 sec.') mocp -k 30;;
        '[<] rewind 30 sec.') mocp -k -30;;
        *) exit 0;;
    esac
}

# >> PAUSE FUNC
pause_commands(){
    selected=$(echo -e "mocp\nmpv" | rofi -theme mytheme -dmenu -p "choose: ")
    case "$selected" in
        mocp) moc_commands;;
        mpv) mpv_commands;;
        *) exit 0;;
    esac
}

# >> CONDITIONS
if [[ "$MOC" = "PLAY" && "$MPV" != "PAUSE" ]]; then
    moc_commands;
elif [[ "$MPV" = "PLAY" && "$MOC" != "PAUSE" ]]; then
    mpv_commands;
else
   pause_commands;
fi

# >> SPADY
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

