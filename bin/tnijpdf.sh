#!/bin/bash
# Last update: 05.02.18, 11:22:54 @x200

# Doc:
# fixme: nie działa dla stron wybranych nie po kolei (np. 12;15-18)

YEL='\033[1;33m' # yellow
NC='\033[0m'     # no color

if pacman -Qs pdftk > /dev/null ; then
    pdftk "$1" cat $2 output $3
    printf "${YEL}### Utworzyłem plik: ###${NC}\n"; ls "$3";
else
    yaourt --noconfirm pdftk && \
    pdftk "$1" cat $2 output $3
    printf "${YEL}### Utworzyłem plik: ###${NC}\n"; ls "$3";
fi
