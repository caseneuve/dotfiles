#!/bin/bash

# ~/.dotfiles/bin/gitstatus.sh
# Created:     27.12.17           ?
# Last update: 13.07.18, 12:51:52 @lenovo

# Doc:
# Podaje status repozytoriów 'dotfiles' i 'emacs' na lokalnym komputerze

# colors
YEL=$(tput setaf 3)
RED=$(tput setaf 9)
GREEN=$(tput setaf 10)
RESET=$(tput sgr0)
BOLD=$(tput bold)

clear

# .dotfiles
echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}DOTFILES ${RESET}"
cd /home/piotr/.dotfiles/
if [[ `git status --porcelain` ]]; then
    echo -e "${YEL}${BOLD}$(git status --porcelain) ${RESET}\n"
else
    echo -e "$(git status | sed -n '2p')\n"
fi

# .emacs.git
echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}EMACS ${RESET}"
cd /home/piotr/.emacs.git
if [[ `git status --porcelain` ]]; then
    echo -e "${YEL}${BOLD}>>$(git status --porcelain) ${RESET}\n"
else
    echo -e "$(git status | sed -n '2p')\n"
fi

# liberal artist
if [ -d "/home/piotr/gitlab/liberal_artist_org" ]; then
    echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}LIBERAL ARTIST: ${RESET}" 
    cd /home/piotr/gitlab/liberal_artist_org
    if [[ `git status --porcelain` ]]; then
        echo -e "${YEL}${BOLD}>>$(git status --porcelain) ${RESET}\n"
    else
    echo -e "$(git status | sed -n '2p')\n"
    fi
fi

# py exercises
if [ -d "/home/piotr/gitlab/py-exercises" ]; then
    echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}PY-EXERCISES ${RESET}" 
    cd /home/piotr/gitlab/py-exercises
    if [[ `git status --porcelain` ]]; then
        echo -e "${YEL}${BOLD}>>$(git status --porcelain) ${RESET}\n"
    else
        echo -e "$(git status | sed -n '2p')\n"
    fi
fi

# repo st 
if [ -d "/home/piotr/suckless/st" ]; then
    echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}SUCKLESS TERMINAL ${RESET}"
    cd /home/piotr/suckless/st
    if [[ `git status --porcelain` ]]; then
        echo -e "${YEL}${BOLD}>>$(git status --porcelain) ${RESET}\n"
    else
        echo -e "$(git status | sed -n '2p')\n"
    fi
fi

#echo -e "...zrobione!\n"

