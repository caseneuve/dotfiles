#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/rofi-execute-script.sh
# Created:     13.07.18, 21:47    @x200
# Last update: 08.12.18, 11:24:35 @lenovo

# Doc:
ST_LIST="mupdf-console" # script to open in terminal
SCRIPT_DIR=~/.config/rofi/scripts/
[[ -z $1 ]] && THEME=i3black_and_red || THEME=$1

selected=$(ls ~/.config/rofi/scripts/ | grep -v execute | rofi -theme $THEME -dmenu -p 'choose a script to execute: ')

if echo $ST_LIST | grep -w $selected > /dev/null; then
    st -e $SCRIPT_DIR$selected
else
    $SCRIPT_DIR$selected
fi
