#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/rofi-execute-script.sh
# Created:     13.07.18, 21:47    @x200
# Last update: 19.07.18, 01:17:59 @x200

# Doc:

selected=$(ls ~/.config/rofi/scripts/ | rofi -theme mytheme -dmenu -p 'choose a script to execute: ')

~/.config/rofi/scripts/$selected

