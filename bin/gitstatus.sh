#!/bin/bash

# ~/.dotfiles/bin/gitstatus.sh
# Created:     27.12.17           ?
# Last update: 17.07.18, 13:45:27 @toshiba

# Doc:
# Podaje status repozytoriów 'dotfiles' i 'emacs' na lokalnym komputerze

# colors
YEL=$(tput setaf 3)
RED=$(tput setaf 9)
GREEN=$(tput setaf 10)
RESET=$(tput sgr0)
BOLD=$(tput bold)

clear
DOT=/home/piotr/.dotfiles/
EMACS=/home/piotr/.emacs.git
#LIB_ART=/home/piotr/gitlab/liberal_artist_org
PY_EX=/home/piotr/gitlab/py-exercises
ST=/home/piotr/git/hub/st

# .dotfiles
echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}DOTFILES ${RESET}"
cd $DOT
if [[ `git status --porcelain` ]]; then
    echo -e "${YEL}${BOLD}$(git status --porcelain) ${RESET}\n"
else
    echo -e "$(git status | sed -n '2p')\n"
fi

# .emacs.git
echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}EMACS ${RESET}"
cd $EMACS 
if [[ `git status --porcelain` ]]; then
    echo -e "${YEL}${BOLD}>>$(git status --porcelain) ${RESET}\n"
else
    echo -e "$(git status | sed -n '2p')\n"
fi

# liberal artist
# if [ -d "/home/piotr/gitlab/liberal_artist_org" ]; then
#     echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}LIBERAL ARTIST: ${RESET}" 
#     cd $LIB_ART
#     if [[ `git status --porcelain` ]]; then
#         echo -e "${YEL}${BOLD}>>$(git status --porcelain) ${RESET}\n"
#     else
#     echo -e "$(git status | sed -n '2p')\n"
#     fi
# fi

# py exercises
# if [ -d "/home/piotr/gitlab/py-exercises" ]; then
#     echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}PY-EXERCISES ${RESET}" 
#     cd $PY_EX
#     if [[ `git status --porcelain` ]]; then
#         echo -e "${YEL}${BOLD}>>$(git status --porcelain) ${RESET}\n"
#     else
#         echo -e "$(git status | sed -n '2p')\n"
#     fi
# fi

# repo st 
if [ -d "/home/piotr/suckless/st" ]; then
    echo "${BOLD}${GREEN}Sprawdzam status repo ${RED}SUCKLESS TERMINAL ${RESET}"
    cd $ST
    if [[ `git status --porcelain` ]]; then
        echo -e "${YEL}${BOLD}>>$(git status --porcelain) ${RESET}\n"
    else
        echo -e "$(git status | sed -n '2p')\n"
    fi
fi

#echo -e "...zrobione!\n"

