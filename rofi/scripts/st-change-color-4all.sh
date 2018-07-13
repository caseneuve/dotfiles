#!/bin/bash

# Path:        ~/bin/st-change-color-4all.sh
# Created:     13.07.18, 15:38    @lenovo
# Last update: 13.07.18, 16:11:24 @lenovo

# Doc: change theme in all st instances simultaneously

windows=$(xdotool search --class st)

for i in $windows; do
    xdotool key --window $i ctrl+F6
done

