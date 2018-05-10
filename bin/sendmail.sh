#!/bin/bash
# Last update: 10.05.18, 18:35:36 @lenovo

# Doc:

## variables:
bold=$(tput bold)
normal=$(tput sgr0)
yel=$(tput setaf 11)
gre=$(tput setaf 10)
red=$(tput setaf 1)
blu=$(tput setaf 4)

## code:
clear

echo "${yel}${bold}### Executing _send mail_ script ${normal}"
echo "##  Multiline in body: \\\n"
echo
## read:
read -p "${bold}Do kogo chcesz wysłać wiadomość?${normal}${blu} " mailaddress
read -p "${normal}${bold}Temat wiadomości:${normal}${blu}                " subject
read -p "${normal}${bold}Treść wiadomości:${normal}${blu}                " body

## save mail in ~/.mail/...
if [ -z "$1" ]; then
    echo -e "Mail sent via RANGER, $(date '+%d/%m/%Y, %H:%M:%S')\nDo: $mailaddress\nTemat: $subject\nAtt: - \nTreść:\n<<\n$body\n>>\n" > ~/.mail/ranger_sent-$(date +%y%m%dT%H%M%S)
else
    echo -e "Mail sent via RANGER, $(date '+%d/%m/%Y, %H:%M:%S')\nDo: $mailaddress\nTemat: $subject\nAtt: $@\nTreść:\n<<\n$body\n>>\n" > ~/.mail/ranger_sent-$(date +%y%m%dT%H%M%S)
fi

## send mail via mutt:
if [ -z "$1" ]; then
    echo -e "${normal}\n...wysyłam"; echo -e "$body" | mutt -s "$subject" $mailaddress > /dev/null 2>&1 &&\
        echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailaddress${normal}${gre} (bez załączników)$1${normal}\n"
else
    echo -e "${normal}\n...wysyłam"; echo -e "$body" | mutt -s "$subject" $mailaddress -a "$@" > /dev/null 2>&1 &&\
        echo -e "\n${gre}Wysłałem wiadomość do ${normal}${bold}$mailaddress${normal}${gre} z następującymi załącznikami:\n$@${normal}\n"
fi

sleep 3s

