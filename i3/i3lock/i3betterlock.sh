#!/bin/bash

# Path:        ~/.dotfiles/i3/i3lock/i3betterlock.sh
# Created:     25.07.18, 21:04    @x200
# Last update: 25.07.18, 21:17:06 @x200

# Doc: lock screen (yaourt betterlockscreen)
# https://github.com/pavanjadhaw/betterlockscreen


[[ $(mocp -i | awk 'NR==1 {print $2}') = "PLAY" ]] && mocp -P
SOC=/tmp/mpv
[[ $(~/bin/mpv-socket -s) = "PLAY" ]] && echo "{ \"command\": [ \"cycle\", \"pause\" ] }" | socat - $SOC 2>/dev/null

betterlockscreen -l dim

