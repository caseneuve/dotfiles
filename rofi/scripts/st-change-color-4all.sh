#!/bin/bash

# Path:        ~/bin/st-change-color-4all.sh
# Created:     13.07.18, 15:38    @lenovo
# Last update: 21.08.18, 14:07:51 @x200

# Doc: change theme in all st instances simultaneously

ST_WIND=$(xdotool search --class st)
SCRATCH_WIND=$(xdotool search --class scratch)
WINDOWS="$ST_WIND $SCRATCH_WIND"

for i in $WINDOWS; do
    xdotool key --window $i ctrl+F6
done

