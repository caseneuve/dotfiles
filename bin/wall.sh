#!/bin/bash

FILE1=$1

cp "$FILE1" ~/.i3/wallpaper/wall.jpg && \
feh --bg-fill ~/.i3/wallpaper/wall.jpg

