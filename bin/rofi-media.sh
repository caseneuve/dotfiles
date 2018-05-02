#!/bin/bash

# Path:        ~/.bin/rofi-media.sh
# Created:     02.05.18, 10:41    @x200
# Last update: 02.05.18, 12:35:38 @x200

# Doc: Script used for rofi to control media players 

clip="$(xclip -o -selection clipboard)"

x=$(rofi -dmenu -i -width 42 -p "" -l 0 -mesg \
"---------------------------------------------------
         MOCP                       MPV             
---------------------------------------------------
[k] pause (toggle)       [a] pause (toggle)
[y] play (clip yank)     [s] play audio (clip yank) 
[p] play (playlist)      [v] play video (clip yank)
[i] stop                 [d] stop (kill)
[j] previous          
[l] next [f]
[r] repeat (toggle)
[q] enqueue (clip yank)
[S] server start")

case $x in

    # MOCP
    k) mocp -G ;;
    y) mocp -l "$clip" ;;
    p) mocp -p ;;
    i) mocp -s ;;
    j) mocp -r ;;
    l|f) mocp -f ;;
    S) mocp -S ;;
    q) mocp -q "$clip" ;;
    r) mocp -o r ;;

    # MPV
    a) echo '{"command": ["cycle", "pause"]}' | socat - /tmp/mpvsocket >/dev/null ;;
    s) mpv --no-video --input-ipc-server=/tmp/mpvsocket "$clip" > /dev/null & ;;
    v) mpv "$clip" >/dev/null & ;;
    d) ps aux | grep mpvsocket | grep -v grep | awk '{print $2}' | xargs kill -9 > /dev/null ;;
    
esac

