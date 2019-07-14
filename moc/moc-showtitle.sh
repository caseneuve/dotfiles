#!/bin/bash

# Path:        ~/.dotfiles/moc/moc-showtitle.sh
# Created:     2019-06-07, 09:10    @toshiba
# Last update: 2019-07-14, 11:41:31 @lenovo

icon="%{T4}%{T-}"
song="$(mocp -Q %song)"

[ -z $song ] && song="$(basename "$(mocp -Q %file)")"
[ ${#song} -gt 25 ] && song="${song:0:25}…"
[ $1 = play ] && color="%{F#ffffff}"

echo "$color$icon $song $(mocp -Q %ct)"
