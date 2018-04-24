#!/bin/bash

# Path:        ~/.dotfiles/bin/wallc.sh
# Created:     24.04.18, 23:01    @manjaroi3
# Last update: 24.04.18, 23:01:36 @manjaroi3

# Doc:

cp "$1" ~/.i3/wall.jpg &&\
    feh --bg-center ~/.i3/wall.jpg

