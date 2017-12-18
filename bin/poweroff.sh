#!/bin/bash

RED=[$(tput setaf 1)
RESET=$(tput sgr0)
bold=$(tput bold)

cd /home/piotr/.dotfiles/
    if [[ `git status --porcelain` ]]; then
        /home/piotr/.bin/gitpush.sh && \
        while true; do
        read -p "${bold}${RED}### Czy chcesz wyłączyć komputer? [t/n] ###${RESET} " yn
        case $yn in
            [Tt]* ) systemctl suspend; break;;
            [Nn]* ) exit;;
             * ) echo "Wpisz [Tt/Nn] :";;
         esac
    done   
 
else
    while true; do
    read -p "${RED}### Czy chcesz wyłączyć komputer? [t/n] ###${RESET} " yn
    case $yn in
        [Tt]* ) systemctl suspend; break;;
        [Nn]* ) exit;;
        * ) echo "Wpisz [Tt/Nn] :";;
    esac
done   
fi
