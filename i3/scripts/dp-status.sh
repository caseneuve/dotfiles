#!/bin/bash

GLYPH=""
FGCOLOR=$(awk '/^*urgent/ {print $2}' $HOME/.Xresources)

[[ -n $(pgrep dropbox) ]] || echo "<span color='$FGCOLOR'> $GLYPH </span>"

case $BLOCK_BUTTON in
    1) pkill -RTMIN=12 i3blocks ;;
    3) notify-send "Dropbox" "$(dropbox-cli status)" ;;
esac
