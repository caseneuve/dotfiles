#!/bin/bash

# Path:        ~/.dotfiles/rofi/scripts/st-change-color-4all.sh
# Created:     2018-07-13, 15:38    @lenovo
# Last update: 2019-03-04, 21:32:28 @x200
# Doc:         change theme in all st instances simultaneously

WINDOWS=$(xdotool search --classname st)

for i in $WINDOWS; do
    xdotool key --window $i ctrl+F6
done

