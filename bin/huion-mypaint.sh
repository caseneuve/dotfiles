#!/bin/bash

# Path:        ~/.dotfiles/bin/huion-mypaint.sh
# Created:     06.07.18, 11:07    @toshiba
# Last update: 06.07.18, 11:33:52 @toshiba

# Doc: Run with MyPaint and Huion Graphical Tablet

tab="HUION Huion Tablet Pad pad"

# undo
xsetwacom --set "$tab" Button 1 "key +ctrl +z -z -ctrl"
# change color
xsetwacom --set "$tab" Button 2 "key c"
# new file
xsetwacom --set "$tab" Button 3 "key +ctrl +n -n -ctrl"
# change brush
xsetwacom --set "$tab" Button 8 "key b"
