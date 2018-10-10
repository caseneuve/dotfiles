#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/rofi-execute-script.sh
# Created:     13.07.18, 21:47    @x200
# Last update: 10.10.18, 15:42:36 @lenovo

# Doc:
st_list="mupdf-console" # script to open in terminal
script_dir=~/.config/rofi/scripts/
selected=$(ls ~/.config/rofi/scripts/ | grep -v execute | rofi -theme mytheme -dmenu -p 'choose a script to execute: ')

if echo $st_list | grep -w $selected > /dev/null; then
    st -e $script_dir$selected
else
    $script_dir$selected
fi
