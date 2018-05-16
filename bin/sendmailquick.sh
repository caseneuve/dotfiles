#!/bin/bash

## variables:
bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)
blu=$(tput setaf 4)
adbook='/home/piotr/Dropbox/config/.mutt_aliases'

## code:
clear

echo "${yel}${bold}### Executing _tnijpdf_ script ${normal}"
echo
read -p "${bold}Do kogo chcesz wysłać wiadomość? ${normal}${blu}" alias
#read -p "Temat wiadomości: " subject
#read -p "Treść wiadomości: " body

## get the email address
if [[ $alias == *@* ]]; then
    mailddrs=$alias
else
    mailddrs=$(grep "alias $alias " $adbook | grep -o "[a-z0-9\.\_]*@[a-z0-9\.]*")
fi

# save mail in ~/.mail/...
if [ -z "$1" ]; then
    echo "${red}${bold}Nie zaznaczyłeś załączników!${normal}";
else
    echo -e "Quickmail sent via RANGER, $(date '+%d/%m/%Y, %H:%M:%S')\n-----------------------------------------------\nDo:     $mailddrs\nAtt:    $@\n" > ~/.mail/ranger_quicksent-$(date +%y%m%dT%H%M)
    echo -e "Wiadomość wysłana automatycznie $(date '+%d/%m o %H:%M'), zawiera następujące pliki\n<< $@ >> \n\n" | mutt -s "ranger" $mailddrs -a "$@" > /dev/null 2>&1 &&\
        echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailddrs${normal}${gre} z następującymi załącznikami:\n'$@'${normal}\n"
fi

sleep 3s

