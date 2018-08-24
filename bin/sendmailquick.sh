#!/bin/bash

## variables:
bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)
blu=$(tput setaf 4)
whibg=$(tput setab 15)
blafg=$(tput setaf 0)
[[ ${#@} > 1 ]] && ATT=" (& $((${#@} - 1)) more...)" || ATT=

adbook='/home/piotr/box/Dropbox/.Config/Mutt/.mutt_aliases'
MAILDIR='/home/piotr/box/Dropbox/.Config/Mutt/.sent'

[[ -d $MAILDIR ]] || mkdir $MAILDIR

## code:
clear

echo "${yel}${bold}### Executing _sendmailquick_ script ${normal}"
echo
read -p "${blu}${bold}Do kogo chcesz wysłać wiadomość? ${normal}" alias
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
    echo -e "Quickmail sent via RANGER, $(date '+%d/%m/%Y, %H:%M:%S')\n-----------------------------------------------\nDo:     $mailddrs\nAtt:    $@\n" > $MAILDIR/ranger_quicksent-$(date +%y%m%dT%H%M)
    echo -e "Wiadomość wysłana automatycznie $(date '+%d/%m o %H:%M'), zawiera następujące pliki:\n$(echo $@ | tr ' ' '\n')\n\n" | neomutt -s "[rng] $1$ATT" $mailddrs -a "$@" > /dev/null 2>&1 &&\
        echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailddrs${normal}${gre} z następującymi załącznikami:\n${whibg}${blafg}${bold}$(echo $@ | tr ' ' '\n')${normal}\n"
fi

sleep 3s

