#!/bin/bash

# Path:        ~/.dotfiles/i3/i3lock/i3betterlock.sh
# Created:     25.07.18, 21:04    @x200
# Last update: 24.11.18, 11:00:32 @x200

# Doc: lock screen (yaourt betterlockscreen)
# https://github.com/pavanjadhaw/betterlockscreen
# https://github.com/guimeira/i3lock-fancy-multimonitor

log_file=/tmp/monit_num
. $log_file

[[ $(mocp -Q %state) = "PLAY" ]] && mocp -P
SOC=/tmp/mpv
[[ $(~/bin/mpv-socket -s) = "PLAY" ]] && echo "{ \"command\": [ \"cycle\", \"pause\" ] }" | socat - $SOC 2>/dev/null

if [[ $num > 1 ]];
then
    i3lock-fancy -n
else
    betterlockscreen -l dim
fi

