#!/bin/bash

## variables:
bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)
blu=$(tput setaf 4)

## code:
clear

echo "${yel}${bold}### Executing _tnijpdf_ script ${normal}"
echo
read -p "${bold}Do kogo chcesz wysłać wiadomość? ${normal}${blu}" mailaddress
#read -p "Temat wiadomości: " subject
#read -p "Treść wiadomości: " body

if [ -z "$1" ]; then
    echo "${red}${bold}Nie zaznaczyłeś załączników!${normal}";
else
    echo -e "Quickmail sent via RANGER, $(date '+%d/%m/%Y, %H:%M')\nDo: $mailaddress\nAtt: $@\n" > ~/.mail/ranger_quicksent-$(date +%y%m%dT%H%M)
    echo -e "Wiadomość wysłana automatycznie $(date '+%d/%m o %H:%M'), zawiera następujące pliki\n<< $@ >> \n\n" | mutt -s "ranger" $mailaddress -a "$@" > /dev/null 2>&1 &&\
        echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailaddress${normal}${gre} z następującymi załącznikami:\n'$@'${normal}\n"
fi

sleep 3s

