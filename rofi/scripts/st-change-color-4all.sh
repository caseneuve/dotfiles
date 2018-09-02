#!/bin/bash

# Path:        ~/bin/st-change-color-4all.sh
# Created:     13.07.18, 15:38    @lenovo
# Last update: 02.09.18, 20:17:51 @lenovo

# Doc: change theme in all st instances simultaneously

ST_WIND=$(xdotool search --class st)
SCRATCH_WIND=$(xdotool search --class scratch)
TERM_WIND=$(xdotool search --class term)
WINDOWS="$ST_WIND $SCRATCH_WIND $TERM_WIND"

for i in $WINDOWS; do
    xdotool key --window $i ctrl+F6
done

