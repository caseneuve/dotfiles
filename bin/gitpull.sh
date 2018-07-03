#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 03.07.18, 17:14:59 @x200

# Doc:
# Aktualizuje repozytoria 'dotfiles', 'emacs/load' oraz wspólny projekt z gitlaba  na lokalnym komputerze
# TODO: loop?

# colors
BLU="$(tput setab 4)"
RED="$(tput setab 1)"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"
clear

echo "${BLU} Aktualizuję repo ${RED}${BOLD} DOTFILES ${RESET}"
cd /home/piotr/.dotfiles 
git pull 
echo

echo "${BLU} Aktualizuję repo ${RED}${BOLD} EMACS ${RESET}"
cd /home/piotr/.emacs.git 
git pull 
echo

if [ -d "/home/piotr/gitlab/liberal_artist_org" ]; then
    echo "${BLU} Aktualizuję repo ${RED}${BOLD} LIBERAL ARTIST ${RESET}"
    cd /home/piotr/gitlab/liberal_artist_org 
    git pull
    echo
    fi

if [ -d "/home/piotr/gitlab/py-exercises" ]; then
    echo "${BLU} Aktualizuję repo ${RED}${BOLD} PY-EXERCISES ${RESET}"
    cd /home/piotr/gitlab/py-exercises
    git pull
    echo
    fi

if [ -d "/home/piotr/suckless/st" ]; then
    echo "${BLU} Aktualizuję repo ${RED}${BOLD} SUCKLESS TERMINAL ${RESET}"
    cd /home/piotr/suckless/st
    git pull
    echo
    fi

if [ -d "/home/piotr/github/emacs-htmlize" ]; then
    echo "${BLU} Aktualizuję repo ${RED}${BOLD} EMACS: htmlize ${RESET}"
    cd /home/piotr/github/emacs-htmlize
    git pull
    echo
    fi

. ~/.bashrc

