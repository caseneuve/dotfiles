#!/bin/bash

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
gre=$(tput setaf 2)
blu=$(tput setaf 4)
whi=$(tput setaf 15)

len=$(( $# - 2 ))

clear

echo -e "${yel}${bold}### Executing _tnijpdf_ script ${normal}"

! [[ pacman -Qs pdftk > /dev/null ]] && echo "Package pdftk missing; install it (aur) first."

if ! [[ "${@:$#}" = *".pdf" ]]; then
    echo "${red}Provide an ${whi}${bold}output ${normal}${red}file name with ${whi}${bold}.pdf ${normal}${red}extension, please."
    echo
    sleep 2s
    exit 1
fi

if ! [ -f "${@:$#}" ]
then
    echo -e "... cutting pages:${blu} ${@:2:$len}\n${normal}... from file:${blu}     $1"
    pdftk "$1" cat "${@:2:$len}" output "${@:$#}"
    if [ -f "${@:$#}" ]
    then
        echo -e "${gre}${bold}### File: ${normal}${bold}${@:$#}${gre} has been produced."
    else
        echo -e "${red}### Error! file: ${normal}${bold} ${@:$#} ${normal}${red} has not been produced!"
    fi
else
    echo -e "${red}### Error! file ${normal}${bold}${@:$#} ${normal}${red}already exists! -- new file has not been produced"
fi

echo
sleep 2s

