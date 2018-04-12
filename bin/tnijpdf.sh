#!/bin/bash
# Last update: 12.04.18, 11:47:13 @x200

# Doc:
# fixme: nie działa dla stron wybranych nie po kolei (np. 12;15-18)
# fixme: jak sprawdzić, czy plik powstał???

YEL='\033[1;33m' # yellow
NC='\033[0m'     # no color
RED='\033[0;31m'

if ! pacman -Qs pdftk > /dev/null ; then
    yaourt --noconfirm pdftk
fi

pdftk "$1" cat $2 output $3 & >/dev/null
#if [ -f "$3" ]; then echo "ok"; else echo "$3 nie istnieje"; fi

#if  ls "$(echo "$3")" ; then
printf "${YEL}### Utworzyłem plik: ###${NC}\n$3\n"
#else
#    printf "${RED}### BŁĄD: ###${NC}\n Nie utworzyłem pliku $3\n"
#fi

