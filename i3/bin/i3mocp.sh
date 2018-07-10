#!/bin/bash

# Path:        ~/.bin/mocp.sh
# Created:     25.04.18, 09:30    @manjaroi3
# Last update: 10.07.18, 22:09:14 @x200

# Doc:
# script to display in i3 status bar (i3blocks) the currently playing track (via mocp) 
# <span> markup is used for pango markup

TITLE=$(mocp -i | grep "^Title:" | sed -e "s/^.*: //")
ARTIST=$(mocp -i | grep "Artist:" | sed -e "s/^.*: //")
ARTIST_LEN=`echo ${#ARTIST}`
SONGTITLE=$(mocp -i | grep "SongTitle:" | sed -e "s/^.*: //")
FILE=$(mocp -i | grep "File:" | sed -e "s/^.*: //")
STATUS=$(mocp -i | grep "State:" | sed -e "s/^.*: //")
TIME=$(mocp -i | grep "CurrentTime:" | sed -e "s/^[A-Za-z]*://")
LEFT=$(mocp -i | grep "TimeLeft:" | sed -e "s/^[A-Za-z]*: //")
MAXA=13
MAXT=13

if [ "$STATUS" != "STOP" ] && [ "$STATUS" != "" ]; then
    if [ "$TITLE" != "" ]; then
        if (( $TITLE_LEN > $MAXT )); then
            let x=$TITLE_LEN-$MAXT
            TITLE=`echo ${TITLE::-$X}…`;
        fi
        if [ "$ARTIST" != "" ]; then
            if (( $ARTIST_LEN > $MAXA )); then
                let x=$ARTIST_LEN-$MAXA
                ARTIST=`echo ${ARTIST::-$x}.:`;
            else
                ARTIST="$ARTIST:";
            fi
        fi
        if [ "$STATUS" = "PLAY" ]; then
            echo -e "<span bgcolor='#36648b'> ♫ $ARTIST $SONGTITLE $TIME [-$LEFT] ♫ </span>"
        else
            echo -e "<span fgcolor='#6F7D91'>♫ $ARTIST $SONGTITLE $TIME [-$LEFT] ♫</span>"
        fi
    else
        if [ "$STATUS" = "PLAY" ]; then
            echo -e "<span bgcolor=\"#34495E\">♫ $FILE $TIME [-$LEFT] ♫ </span>"
        else
            echo -e "♫ $FILE $TIME [-$LEFT] ♫"
        fi
    fi
    case $BLOCK_BUTTON in
            1) mocp -r ;; # left click = previous song
            2) mocp -G ;; # middle click = toggle pause/play
            3) mocp -f ;; # right click = next song
            4) mocp -k -10 ;; # scroll up = backward 10 sec
            5) mocp -k 10 ;; # scroll down = foreard 10 sec
        esac
        exit 0
else
    echo -e ""
fi

