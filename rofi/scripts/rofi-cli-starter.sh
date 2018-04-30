#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/rofi-cli-starter.sh
# Created:     29.04.18, 16:42    @x200
# Last update: 30.04.18, 09:01:41 @x200

# Doc:

list="newsboat (rss)\nneomutt (mail)\nranger\nqutebrowser-private\nmocp\ncalcurse (kal)"

#x=$(echo -e $list | rofi -dmenu -p "START CLI APP")
echo -e $list

case $1 in
    'newsboat (rss)'|'rss')
        i3-msg "workspace 10; exec --no-startup-id st -e newsboat" >/dev/null && pkill rofi ;;
    'neomutt (mail)'|mmm)
        i3-msg "workspace 10; exec --no-startup-id st -e neomutt" && pkill rofi ;;
    ranger|rrr)
        i3-msg "workspace 6; exec --no-startup-id st -e ranger" && pkill rofi ;;
    mocp)
        i3-msg "workspace 8; exec --no-startup-id st -e mocp"; pkill rofi ;;
    'calcurse (kal)')
        i3-msg "exec --no-startup-id st -e calcurse"; pkill rofi ;;
    *) ;;
esac

