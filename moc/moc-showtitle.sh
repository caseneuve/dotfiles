#!/bin/bash

# Path:        ~/.dotfiles/moc/moc-showtitle.sh
# Created:     2019-06-07, 09:10    @toshiba
# Last update: 2019-06-08, 22:04:57 @toshiba

song="$(mocp -Q %song)"
icon="%{T4}%{T-}"

if [[ -n $song ]]; then
    [[ ${#song} -gt 25 ]] && song="${song:0:25}…"
else
    song="$(basename "$(mocp -Q %file)")"
fi

if [[ $1 = play ]]; then
    echo "%{F#ffffff}$icon $song $(mocp -Q %ct)"
else
    echo "$icon $song $(mocp -Q %ct)"
fi
