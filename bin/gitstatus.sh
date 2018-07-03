#!/bin/bash

# ~/.dotfiles/bin/gitstatus.sh
# Created:     27.12.17           ?
# Last update: 03.07.18, 03:45:16 @lenovo

# Doc:
# Podaje status repozytoriów 'dotfiles' i 'emacs' na lokalnym komputerze

# colors
YELb=$(tput setab 3)
REDb=$(tput setab 1)
CYAN=$(tput setab 6)
RESET=$(tput sgr0)
BOLD=$(tput bold)

clear

# .dotfiles
echo "${CYAN} Sprawdzam status repo ${RESET}${BOLD}${REDb} DOTFILES ${RESET}"
cd /home/piotr/.dotfiles/
if [[ `git status --porcelain` ]]; then
    echo -e "${YELb}${BOLD} >>$(git status --porcelain) ${RESET}\n"
else
    echo -e " $(git status | sed -n '2p')\n"
fi

# .emacs.git
echo "${CYAN} Sprawdzam status repo ${RESET}${BOLD}${REDb} EMACS ${RESET}"
cd /home/piotr/.emacs.git
if [[ `git status --porcelain` ]]; then
    echo -e "${YELb}${BOLD} >>$(git status --porcelain) ${RESET}\n"
else
    echo -e " $(git status | sed -n '2p')\n"
fi

# liberal artist
if [ -d "/home/piotr/gitlab/liberal_artist_org" ]; then
    echo "${CYAN} Sprawdzam status repo ${RESET}${BOLD}${REDb} LIBERAL ARTIST: ${RESET}" 
    cd /home/piotr/gitlab/liberal_artist_org
    if [[ `git status --porcelain` ]]; then
        echo -e "${YELb}${BOLD} >>$(git status --porcelain) ${RESET}\n"
    else
    echo -e " $(git status | sed -n '2p')\n"
    fi
fi

# py exercises
if [ -d "/home/piotr/gitlab/py-exercises" ]; then
    echo "${CYAN} Sprawdzam status repo ${RESET}${BOLD}${REDb} PY-EXERCISES ${RESET}" 
    cd /home/piotr/gitlab/py-exercises
    if [[ `git status --porcelain` ]]; then
        echo -e "${YELb}${BOLD} >>$(git status --porcelain) ${RESET}\n"
    else
        echo -e " $(git status | sed -n '2p')\n"
    fi
fi

# repo st 
if [ -d "/home/piotr/suckless/st" ]; then
    echo "${CYAN} Sprawdzam status repo ${RESET}${BOLD}${REDb} SUCKLESS TERMINAL ${RESET}"
    cd /home/piotr/suckless/st
    if [[ `git status --porcelain` ]]; then
        echo -e "${YELb}${BOLD} >>$(git status --porcelain) ${RESET}\n"
    else
        echo -e " $(git status | sed -n '2p')\n"
    fi
fi

echo -e " ...zrobione!\n"

