#!/bin/bash

# Path:        ~/bin/st-change-color-4all.sh
# Created:     13.07.18, 15:38    @lenovo
# Last update: 02.09.18, 21:10:42 @lenovo

# Doc: change theme in all st instances simultaneously
# note: refactored, 02/09/2018

WINDOWS=$(xdotool search --classname st-256color)

for i in $WINDOWS; do
    xdotool key --window $i ctrl+F6
done

# OLD:
# ST=$(xdotool search --class st)
# SCRATCH=$(xdotool search --class scratch)
# TERM=$(xdotool search --class term)
# CALC=$(xdotool search --class calculator)

# WINDOWS="$ST $SCRATCH $TERM $CALC"

# for i in "st" "scratch" "term" "calculator" "mail" "rss"; do
#     WINDOWS="$WINDOWS $(xdotool search --class $i)"
# done
