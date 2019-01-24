#!/bin/bash

cp "$1" ~/.i3/wall.jpg &&\
    feh --bg-fill ~/.i3/wall.jpg

[[ $(pacman -Q betterlockscreen) ]] && betterlockscreen -u "$1" &>/dev/null &

