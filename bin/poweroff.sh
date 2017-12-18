#!/bin/bash

YEL=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)
bold=$(tput bold)

cd /home/piotr/.dotfiles/
    if [[ `git status --porcelain` ]]; then
        clear
        printf "${YEL}${bold}Git status - masz do opublikowania następujące zmiany:${RESET}\n$(git status --porcelain)\n\n"
        /home/piotr/.bin/gitpush.sh && \
        while true; do
        printf "\n"
        read -p "${bold}${RED}### Czy chcesz wyłączyć komputer? [t/n] ###${RESET} " yn
        case $yn in
            [Tt]* ) systemctl poweroff -i; break;;
            [Nn]* ) exit;;
            * ) echo "${bold}${RED} Wpisz [Tt/Nn] :${RESET} ";;
         esac
    done   
 
else
    while true; do
    clear
    read -p "${bold}${RED}\n### Czy chcesz wyłączyć komputer? [t/n] ###${RESET} " yn
    case $yn in
        [Tt]* ) systemctl poweroff -i; break;;
        [Nn]* ) exit;;
        * ) echo "${bold}${RED} Wpisz [Tt/Nn] :${RESET} ";;
    esac
done   
fi
