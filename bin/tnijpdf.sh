#!/bin/bash
# Last update: 12.04.18, 19:35:11 @x200

# Doc:
# fixme: nie działa dla stron wybranych nie po kolei (np. 12;15-18)
# fixme: jak sprawdzić, czy plik powstał???
# todo: jak wysłać błąd pdftk donikąd?

YEL='\033[1;33m' # yellow
NC='\033[0m'     # no color
RED='\033[1;31m'

if ! pacman -Qs pdftk > /dev/null ; then
    yaourt --noconfirm pdftk
fi

if ! [ -f $3 ]
then
    #pdftk "$1" cat $2 output $3 &> /dev/null
    pdftk "$1" cat $2 output $3 
    if [ -f $3 ] 
    then
        echo -e "${YEL}### Utworzyłem plik: ###${NC}\n$3\n"
    else
        echo -e "${RED}### Błąd, nie utworzyłem pliku:${NC} $3 ${RED}###\n"
    fi
else
    echo -e "${RED}### Plik $3 już istnieje! ###\n${NC}"
fi

