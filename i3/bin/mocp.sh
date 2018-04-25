#!/bin/bash

# Path:        ~/.bin/mocp.sh
# Created:     25.04.18, 09:30    @manjaroi3
# Last update: 25.04.18, 11:10:29 @manjaroi3

# Doc:
# script to show track currently playing on i3 status bar (i3blocks)
# <span> markup is used for pango markup

TITLE=$(mocp -i | grep "^Title:" | sed -e "s/^.*: //")
ARTIST=$(mocp -i | grep "Artist:" | sed -e "s/^.*: //")
SONGTITLE=$(mocp -i | grep "SongTitle:" | sed -e "s/^.*: //")
FILE=$(mocp -i | grep "File:" | sed -e "s/^.*: //")
STATUS=$(mocp -i | grep "State:" | sed -e "s/^.*: //")

if [ "$STATUS" != "STOP" ]; then
    if [ "$TITLE" != "" ]; then
        if [ "$ARTIST" != "" ]; then
            ARTIST="$ARTIST -";
        fi
        if [ "$STATUS" = "PLAY" ]; then
            echo -e "<span bgcolor=\"#00FF007F\">[[ ♫ $ARTIST $SONGTITLE ]]</span>"
        else
            echo -e "[[ ♫ $ARTIST $SONGTITLE ]]"
        fi
    else
        if [ "$STATUS" = "PLAY" ]; then
            echo -e "<span bgcolor=\"#00FF007F\">[[ ♫ $FILE ]]</span>"
        else
            echo -e "[[ ♫ $FILE ]]"
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
    echo -e " "
fi

