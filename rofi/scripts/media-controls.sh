#!/bin/bash

# Path:        ~/scr/mpv-commands.sh
# Created:     14.07.18, 22:09    @x200
# Last update: 25.07.18, 20:36:53 @x200

## Doc: MOCP & MPV controls for rofi
# TODO: get current position > notify send
# TODO: set position to go
# TODO: change mode from video to audio ???
# TODO: 25/07/2018 POPRAWIĆ WARUNKI!!! | done: problem - skrypty nie czytają /bin, trzeba podawać pełną ścieżkę

# >> VARIABLES
CLIP="$(xclip -o -selection clipboard)"
MOC=$(mocp -i | awk 'NR==1 {print $2}')
MPV=$(~/bin/mpv-socket -s)
GLYPH=

# >> MPV FUNC
mpv_commands(){
    SOC=/tmp/mpv
    POSITION=$(echo '{ "command": ["get_property_string", "time-pos"] }' | socat - $SOC 2>/dev/null | jq .data | xargs | cut -d'.' -f 1)
    selected=$(echo -e \
                    "[>] forward 30s.
[<] rewind 30s.
[n] next
[p] previous
[1] pause toggle
[2] stop
[4] stream audio yank
[3] load video stream
[5] show playlist" | rofi -theme mytheme -dmenu -p "$GLYPH  MPV:")
    case "$selected" in
        '[>] forward 30s.') echo '{ "command": [ "seek", "30" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
        '[<] rewind 30s.') echo '{ "command": [ "seek", "-30" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
        '[n] next') echo '{ "command": [ "playlist-next" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
        '[p] previous') echo '{ "command": [ "playlist-prev" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
        '[1] pause toggle') echo '{ "command": [ "cycle", "pause" ] }' | socat - $SOC 2>/dev/null && exit 0 ;;
        '[4] stream audio yank') mpv --really-quiet --no-video --input-ipc-server=$SOC "$CLIP" > /dev/null & ;;
        '[2] stop') echo '{ "command": [ "stop" ] }' | socat - $SOC 2>/dev/null; pkill -RTMIN+4 i3blocks && exit 0 ;;
        '[3] load video stream') [[ $POSITION ]] && echo '{ "command": [ "loadfile", "$CLIP", "append-play" ] }' | socat - $SOC 2>/dev/null || mpv "$CLIP" --input-ipc-server=$SOC > /dev/null &;;
        '[5] show playlist') notify-send "MPV Playlist:
-------------" "$(~/bin/mpv-socket -P)"
                          #"$(echo '{ "command": ["get_property", "playlist"] }' | socat - $SOC 2>/dev/null | jq .data[].filename | xargs)"
                          ;;
        # 'position') ~/scr/mpv-set-playlist-post.sh && exit 0 ;;
        *) exit 0;;
    esac
}

# >> MOC FUNC
moc_commands(){
    selected=$(echo -e \
                    "[1] pause toggle
[2] play (clip yank)
[3] stop
[p] previous
[n] next
[r] repeat (toggle)
[q] enqueue (clip yank)
[!] play (list)
[>] forward 30s.
[<] rewind 30s." | rofi -theme mytheme -dmenu -p "$GLYPH  MOCP:")
    
    case "$selected" in
        '[1] pause toggle') mocp -G ;;
        '[2] play (clip yank)') mocp -l "$CLIP" ;;
        '[3] stop') mocp -s ;;
        '[p] previous') mocp -r ;;
        '[n] next') mocp -f ;;
        '[r] repeat (toggle)') mocp -o r ;;
        '[q] enqueue (clip yank)') mocp -q "$CLIP" ;;
        '[!] play (list)') mocp -p;;
        '[>] forward 30s.') mocp -k 30;;
        '[<] rewind 30s.') mocp -k -30;;
        *) exit 0;;
    esac
}

# >> PAUSE FUNC
pause_commands(){
    selected=$(echo -e "[a] mocp\n[f] mpv" | rofi -theme mytheme -dmenu -p "$GLYPH CHOOSE:")
    case "$selected" in
        '[a] mocp') moc_commands;;
        '[f] mpv') mpv_commands;;
        *) exit 0;;
    esac
}

# >> CONDITIONS
if [[ "$MOC" = "STOP" && "$MPV" = "NOT ACTIVE" || "$MOC" = "PAUSE" && "$MPV" = "PAUSE" ]]; then 
    pause_commands;
elif [[ "$MOC" = "STOP" && "$MPV" = "PLAY" || "$MOC" = "PAUSE" && "$MPV" = "PLAY" || "$MOC" = "STOP" && "$MPV" = "PAUSE" ]]; then
    mpv_commands;
elif [[ "$MPV" = "NOT ACTIVE" && "$MOC" = "PLAY" || "$MPV" = "PAUSE" && "$MOC" = "PLAY" || "$MPV" = "NOT ACTIVE" && "$MOC" = "PAUSE" ]]; then
    moc_commands;
else
    notify-send "fajlur";
fi

