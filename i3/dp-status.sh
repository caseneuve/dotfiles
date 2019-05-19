#!/bin/bash

# Path:        ~/.dotfiles/i3/dp-status.sh
# Created:     2019-02-16, 09:49:23 @x200
# Last update: 2019-05-19, 16:38:42 @lenovo
# Doc:         alert when dropbox server isn't running

GLYPH=""
FGCOLOR=$(awk '/^*i3urgent/ {print $2}' $HOME/.Xresources)

[[ -n $(pgrep dropbox) ]] || echo "<span color='$FGCOLOR'>$GLYPH </span>"

case $BLOCK_BUTTON in
    1) pkill -RTMIN+13 i3blocks ;;
esac

