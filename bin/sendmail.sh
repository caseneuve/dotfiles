#!/bin/bash
# Last update: 17.05.18, 07:32:31 @manjaroi3

# Doc:

## variables:
bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)
blu=$(tput setaf 4)
adbook='/home/piotr/Dropbox/config/.mutt_aliases'
MAILDIR='/home/piotr/Dropbox/config/mutt/.sent'

[[ -d $MAILDIR ]] || mkdir $MAILDIR

## code:
clear

echo "${yel}${bold}### Executing _send mail_ script ${normal}"
echo "##  Multiline in body: \\\n"
echo
## read:
read -p "${bold}Do kogo chcesz wysłać wiadomość?${normal}${blu} " alias
read -p "${normal}${bold}Temat wiadomości:${normal}${blu}                " subject
read -p "${normal}${bold}Treść wiadomości:${normal}${blu}                " body

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
        echo -e "${normal}\n...wysyłam"; echo -e "$body" | mutt -s "$subject" $mailddrs > /dev/null 2>&1 &&\
            echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailddrs${normal}${gre} (bez załączników)$1${normal}\n"
else
    echo -e "${normal}\n...wysyłam"; echo -e "$body" | mutt -s "$subject" $mailddrs -a "$@" > /dev/null 2>&1 &&\
        echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailddrs${normal}${gre} z następującymi załącznikami:\n${red}$@${normal}\n"
fi

sleep 3s

