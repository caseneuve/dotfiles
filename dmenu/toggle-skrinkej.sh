#!/bin/bash

# Path:        ~/.dotfiles/dmenu/toggle-skrinkej.sh
# Created:     2019-03-27, 15:58    @lenovo
# Last update: 2019-03-27, 16:12:49 @lenovo
# Doc:

if [[ -n $(ps aux | rg screenkey | rg -v rg) ]]; then
    pkill screenkey
else
    screenkey --scr 1 \
              --font monospace \
              -s small \
              --bg-color "green" \
              --font-color "white" &
fi
