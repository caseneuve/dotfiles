#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/rofi-execute-script.sh
# Created:     13.07.18, 21:47    @x200
# Last update: 13.07.18, 22:13:28 @x200

# Doc:

# selected=$(ls ~/scr/rofi | rofi -theme mytheme -dmenu -p 'choose a script to execute: ')
# [[ -z "$selected"]] && exit 1
#~/scr/rofi/$selected && exit 0
opts="system update -notify\nsystem update -run pacman\nsystem update -run yaourt"
app=~/bin/sys-updt.sh
selected=$(echo -e $opts | rofi -theme mytheme -dmenu -p 'choose a script to execute: ')

case "$selected" in
    'system update -notify') $app -n && exit 0;;
    'system update -run pacman') $app -r && exit 0;;
    'system update -run yaourt') $app -y && exit 0;;
    *) exit 1
esac

