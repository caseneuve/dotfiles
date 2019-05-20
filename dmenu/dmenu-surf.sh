#!/bin/bash

# Path:        ~/.dotfiles/dmenu/dmenu-surf.sh
# Created:     2019-05-20, 17:23    @x200
# Last update: 2019-05-20, 18:45:38 @x200
# Doc:

BOOKMARKS=~/.surf/bookmarks.txt

[[ -n $BOOKMARKS ]] && LINES=$(wc -l < $BOOKMARKS) opt=$(sort $BOOKMARKS | dmenu -p "surf: " -l $LINES) || opt=$(dmenu -p "surf: ")

[[ -n $opt ]] && surf https://$opt & disown
