#!/bin/bash
# Last update: 30.07.18, 22:09:01 @x200

# Doc:

## variables:
bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)
blu=$(tput setaf 4)
whibg=$(tput setab 15)
blafg=$(tput setaf 0)
redbg=$(tput setab 1)

adbook='/home/piotr/box/Dropbox/.Config/Mutt/.mutt_aliases'
MAILDIR='/home/piotr/box/Dropbox/.Config/Mutt/.sent'

[[ -d $MAILDIR ]] || mkdir $MAILDIR

## code:
clear

echo "${yel}${bold}### Executing _send mail_ script ${normal}"
echo "##  Multiline in body: \\\n"
echo
## read:
read -p "${blu}${bold}Do kogo chcesz wysłać wiadomość?${normal} " alias
read -p "${blu}${bold}Temat wiadomości:${normal}                " subject
read -p "${blu}${bold}Treść wiadomości:${normal}                " body

## get the email address
if [[ $alias == *@* ]]; then
    mailddrs=$alias
else
    mailddrs=$(grep "alias $alias " $adbook | grep -o "[a-z0-9\.\_]*@[a-z0-9\.]*")
fi

## save mail in ~/.mail/...
if [ -z "$1" ]; then
    echo -e "Mail sent via RANGER, $(date '+%d/%m/%Y, %H:%M:%S')\n------------------------------------------\nDo:    $mailddrs\nTemat: $subject\nAtt:   - \n<-----------------------------------------\n\n$body\n\n----------------------------------------->\n" > $MAILDIR/ranger_sent-$(date +%y%m%dT%H%M%S)
else
    echo -e "Mail sent via RANGER, $(date '+%d/%m/%Y, %H:%M:%S')\n------------------------------------------\nDo:    $mailddrs\nTemat: $subject\nAtt:   $@\n<-----------------------------------------\n\n$body\n\n----------------------------------------->" > $MAILDIR/ranger_sent-$(date +%y%m%dT%H%M%S)
fi

## send mail via mutt:
if [ -z "$1" ]; then
        echo -e "${normal}\n...wysyłam"; echo -e "$body" | neomutt -s "$subject" $mailddrs > /dev/null 2>&1 &&\
            echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailddrs${normal}${gre} (bez załączników)$1${normal}\n"
else
    echo -e "${normal}\n...wysyłam"; echo -e "$body" | neomutt -s "$subject" $mailddrs -a "$@" > /dev/null 2>&1 &&\
        echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailddrs${normal}${gre} z następującymi załącznikami:\n${redbg}${blafg}${bold}$@${normal}\n"
fi

sleep 3s

