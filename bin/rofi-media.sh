#!/bin/bash

# Path:        ~/.bin/rofi-media.sh
# Created:     02.05.18, 10:41    @x200
# Last update: 13.07.18, 10:18:54 @toshiba

# Doc: Script used for rofi to control media players 
# TODO: dokończyć funkcje dla MPV i uzgodnić to z MOC
# - może niektóre funkcje uda się płączyć w skryptach, żeby ograniczyć liczbę klawiszy

MPV_PIPE=/tmp/mp_pipe
MPV_PIPE2=/tmp/mp_pipe2
CLIP="$(xclip -o -selection clipboard)"

x=$(rofi -dmenu -i -width 46 -p "" -l 0 -mesg \
"-------------------------------------------------------
         MOCP                          MPV             
-------------------------------------------------------
[k] pause (toggle)       [a/A] pause (toggle)
[y] play (clip yank)     [s]   play audio (clip yank) 
[p] play (playlist)      [v]   play video (clip yank)
[i] stop                 [d/D] stop video/audio (kill)
[j] previous             [u/U] previous V/A on list 
[l] next [f]             [o/O] next V/A on list
[r] repeat (toggle)      [lesser/bigger] seek +/- 30 s.
[q] enqueue (clip yank)
[S] server start")

case $x in
    # MOCP
    k) mocp -G ;;
    y) mocp -l "$CLIP" ;;
    p) mocp -p ;;
    i) mocp -s ;;
    j) mocp -r ;;
    l|f) mocp -f ;;
    S) mocp -S ;;
    q) mocp -q "$CLIP" ;;
    r) mocp -o r ;;
    # MPV
    # a) echo '{"command": ["cycle", "pause"]}' | socat - /tmp/mpvsocket >/dev/null ;;
    # s) mpv --no-video --input-ipc-server=/tmp/mpvsocket "$CLIP" > /dev/null & ;;
    # v) mpv "$CLIP" >/dev/null & ;;
    # d) ps aux | grep mpvsocket | grep -v grep | awk '{print $2}' | xargs kill -9 > /dev/null ;;
    a) echo "cycle pause" > $MPV_PIPE;;
    A) echo "cycle pause" > $MPV_PIPE2;;
    # fixme: trzeba tu dodać skrypt (~/biurko/bash/quueuempv2.sh)
    s) echo "loadfile \"$CLIP\" append-play" > $MPV_PIPE2;;
        # mpv --no-video --save-position-on-quit --input-file=$MPV_PIPE2 "$CLIP" &
    v) ~/bin/queuempv "$CLIP"
        # &&
        # notify-send -u low "Rofi-media:
        # -----------" "Video is loading, please wait..."
        ;;
    d) echo "write-watch-later-config; stop" > $MPV_PIPE;;
    D) echo "quit" > $MPV_PIPE2;;
    u) echo "write-watch-later-config; playlist-prev" > $MPV_PIPE;;
    U) echo "playlist-prev" > $MPV_PIPE2;;
    o) echo "write-watch-later-config; playlist-next" > $MPV_PIPE;;
    O) echo "playlist-next" > $MPV_PIPE2;;
    '>') echo "seek 30" > $MPV_PIPE;;
    '<') echo "seek -30" > $MPV_PIPE;;
esac

