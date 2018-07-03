#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 03.07.18, 03:35:07 @lenovo

# Doc:
#
# Aktualizuje repozytoria 'dotfiles', 'emacs/load' oraz wspólny projekt z gitlaba  na lokalnym komputerze

# colors
BLU="$(tput setab 4)"
RED="$(tput setab 1)"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"
clear

echo "${BLU} Aktualizuję repo ${RED}${BOLD} DOTFILES ${RESET}"
cd /home/piotr/.dotfiles 
echo -e "$(git pull)\n"

echo "${BLU} Aktualizuję repo ${RED}${BOLD} EMACS ${RESET}"
cd /home/piotr/.emacs.git 
echo -e "$(git pull)\n"

if [ -d "/home/piotr/gitlab/liberal_artist_org" ]; then
    echo "${BLU} Aktualizuję repo ${RED}${BOLD} LIBERAL ARTIST ${RESET}"
    cd /home/piotr/gitlab/liberal_artist_org 
    echo -e "$(git pull)\n"
    fi

if [ -d "/home/piotr/gitlab/py-exercises" ]; then
    echo "${BLU} Aktualizuję repo ${RED}${BOLD} PY-EXERCISES ${RESET}"
    cd /home/piotr/gitlab/py-exercises
    echo -e "$(git pull)\n"
    fi

if [ -d "/home/piotr/suckless/st" ]; then
    echo "${BLU} Aktualizuję repo ${RED}${BOLD} SUCKLESS TERMINAL ${RESET}"
    cd /home/piotr/suckless/st
    echo -e "$(git pull)\n"
    fi

. ~/.bashrc

