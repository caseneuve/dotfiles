#!/bin/bash

# Path:        ~/.bin/mocp.sh
# Created:     25.04.18, 09:30    @manjaroi3
# Last update: 30.05.18, 21:49:30 @x200

# Doc:
# script to display in i3 status bar (i3blocks) the currently playing track (via mocp) 
# <span> markup is used for pango markup

TITLE=$(mocp -i | grep "^Title:" | sed -e "s/^.*: //")
ARTIST=$(mocp -i | grep "Artist:" | sed -e "s/^.*: //")
SONGTITLE=$(mocp -i | grep "SongTitle:" | sed -e "s/^.*: //")
FILE=$(mocp -i | grep "File:" | sed -e "s/^.*: //")
STATUS=$(mocp -i | grep "State:" | sed -e "s/^.*: //")
TIME=$(mocp -i | grep "CurrentTime:" | sed -e "s/^[A-Za-z]*://")

if [ "$STATUS" != "STOP" ] && [ "$STATUS" != "" ]; then
    if [ "$TITLE" != "" ]; then
        if [ "$ARTIST" != "" ]; then
            ARTIST="$ARTIST -";
        fi
        if [ "$STATUS" = "PLAY" ]; then
#            echo -e "<span bgcolor=\"#00FF007F\"> ♫ $ARTIST $SONGTITLE -- $TIME ♫ </span>"
            echo -e "<span bgcolor=\"#2980b9\"> ♫ $ARTIST $SONGTITLE -- $TIME ♫ </span>"
        else
            echo -e "♫ $ARTIST $SONGTITLE -- $TIME ♫"
        fi
    else
        if [ "$STATUS" = "PLAY" ]; then
#            echo -e "<span bgcolor=\"#00FF007F\"> ♫ $FILE -- $TIME </span>"
            echo -e "<span bgcolor=\"#2980b9\"> ♫ $FILE -- $TIME </span>"
        else
            echo -e "♫ $FILE -- $TIME ♫"
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

