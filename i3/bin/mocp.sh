#!/bin/bash

# Path:        ~/.bin/mocp.sh
# Created:     25.04.18, 09:30    @manjaroi3
# Last update: 25.04.18, 09:39:09 @manjaroi3

# Doc:

TITLE=$(mocp -i | grep "^Title:" | sed -e "s/^.*: //")
ARTIST=$(mocp -i | grep "Artist:" | sed -e "s/^.*: //")
SONGTITLE=$(mocp -i | grep "SongTitle:" | sed -e "s/^.*: //")

if [ "$TITLE" != "" ]; then
  if [ "$ARTIST" != "" ]; then ARTIST="$ARTIST -"; fi
  echo -e "[[ ♫ $ARTIST $SONGTITLE ]]"
  case $BLOCK_BUTTON in
  1) mocp -r ;; # left click = previous song
  2) mocp -G ;; # middle click = toggle pause/play
  3) mocp -f ;; # right click = next song
  esac
  exit 0
else echo -e " "
fi
