#!/bin/bash
# Last update: 09.05.18, 10:39:03 @manjaroi3

# Doc:
# fixme: nie działa dla stron wybranych nie po kolei (np. 12;15-18)
# done: należy wpisywać w formacie "n-n n n-n" -> bez przecinków i w cudzysłowie!
# fixme: jak sprawdzić, czy plik powstał???
# todo: jak wysłać błąd pdftk donikąd?

bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)

clear

echo "${yel}${bold}### Executing _tnijpdf_ script ${normal}"
echo

if ! pacman -Qs pdftk > /dev/null ; then
    yaourt --noconfirm pdftk
fi

if ! [ -f $3 ]
then
    #pdftk "$1" cat $2 output $3 &> /dev/null
    pdftk "$1" cat $2 output $3 
    if [ -f $3 ] 
    then
        echo -e "${yel}### Utworzyłem plik: ###${norlmal}\n$3\n"
    else
        echo -e "${red}### Błąd, nie utworzyłem pliku:${normal} $3 ${red}###\n"
    fi
else
    echo -e "${red}### Plik $3 już istnieje! ###\n${normal}"
fi

sleep 2s

