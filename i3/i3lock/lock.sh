#!/bin/bash
scrot /tmp/screen.png
#convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
#convert /tmp/screen.png -paint 3 -modulate 80 /tmp/screen.png
convert /tmp/screen.png -paint 1.5 /tmp/screen.png
[[ -f ~/.i3/i3lock/lock.png ]] && convert /tmp/screen.png  ~/.i3/i3lock/lock.png  -gravity center -composite -matte /tmp/screen.png
mocp -P
i3lock -u -e -i /tmp/screen.png
