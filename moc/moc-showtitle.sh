#!/bin/bash

# Path:        ~/.dotfiles/moc/moc-showtitle.sh
# Created:     2019-06-07, 09:10    @toshiba
# Last update: 2019-06-07, 10:49:10 @toshiba

song="$(mocp -Q %song)"

if [[ -n $song ]]; then
    [[ ${#song} -gt 25 ]] && song="${song:0:25}…"
else
    song="$(basename "$(mocp -Q %file)")"
fi

if [[ $1 = play ]]; then
    echo "%{F#ffffff}$song $(mocp -Q %ct)"
else
    echo "$song $(mocp -Q %ct)"
fi
