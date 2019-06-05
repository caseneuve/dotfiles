#!/bin/bash

#* ---------------------------------------------
# Path:        ~/.dotfiles/dmenu/dmenu-media.sh
# Created:     2019-06-05, 22:12    @x200
# Last update: 2019-06-05, 22:52:21 @x200
# Doc:
# Todo:        [ ] 05/06 mpv controls →
#                  mpv-socket2.sh in ../bin
#              [ ]       intelligent menu? →
#                  check what's being played

#* choose
medium=$(echo -e "[1] mocp\n[2] mpv" | dmenu -p "choose: ")

#* mocp
mocp_controls(){
    selected=">"
    while [[ "$selected" =~ ">" || "$selected" =~ "<" ]]
    do
            selected=$(echo -e \
                    "[1] pause toggle
[3] stop
[p] previous
[n] next
[r] repeat (toggle)
[!] play (list)
[>] forward 30s.
[<] rewind 30s.
[q] quit menu
info" | dmenu -p "$GLYPH  MOCP:" -l 10)
    case "$selected" in
        '[1] pause toggle') mocp -G ;;
        '[2] play (list)') mocp -p ;;
        '[3] stop') mocp -s ;;
        '[p] previous') mocp -r ;;
        '[n] next') mocp -f ;;
        '[r] repeat (toggle)') mocp -t r ;;
        '[>] forward 30s.') mocp -k 30;;
        '[<] rewind 30s.') mocp -k -30;;
        *quit*) exit ;;
        info) notify-send -u low "MOCP:" "$(mocp -i)";;
        *) exit 0;;
    esac
    done
}

#* what next
case $medium in
    *1*) mocp_controls ;;
    *2*) mpv_controls ;;
esac


#* TODO: mpv
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
[5] show playlist" | dmenu -p "$GLYPH  MPV:" -l 9) # rofi -theme $THEME -dmenu
    case "$selected" in
        *) exit 0;;
    esac
}
