#!/bin/bash

# Path:        ~/.dotfiles/i3/i3lock/lock.sh
# Created:     ?
# Last update: 24.11.18, 10:44:07 @x200

# Doc: old script; removed by i3betterlock 
# note: requies i3lock

[[ $(pgrep rofi) ]] && pkill rofi; sleep 0.2s

cp ~/.i3/wall.jpg /tmp/screen.png

convert /tmp/screen.png -paint 1.5 /tmp/screen.png

[[ -f $HOME/.dotfiles/i3/i3lock/lock.png ]] && convert /tmp/screen.png  ~/.dotfiles/i3/i3lock/lock.png  -gravity center -composite -matte /tmp/screen.png

mocp -P

i3lock -u -e -i /tmp/screen.png

