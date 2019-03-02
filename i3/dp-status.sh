#!/bin/bash

GLYPH=""
FGCOLOR=$(cat $HOME/.Xresources | awk '/^*urgent/ {print $2}')

[[ -n $(pgrep dropbox) ]] || echo "<span color='$FGCOLOR'>$GLYPH </span>"
