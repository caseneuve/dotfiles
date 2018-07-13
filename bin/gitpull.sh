#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 13.07.18, 12:44:45 @lenovo

# Doc:
# Aktualizuje repozytoria 'dotfiles', 'emacs/load' oraz wspólny projekt z gitlaba  na lokalnym komputerze
# TODO: loop?

# colors
ORANGE="$(tput setaf 11)"
RED="$(tput setaf 9)"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"
clear

echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}DOTFILES ${RESET}"
cd /home/piotr/.dotfiles 
git pull 
echo

echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}EMACS ${RESET}"
cd /home/piotr/.emacs.git 
git pull 
echo

if [ -d "/home/piotr/gitlab/liberal_artist_org" ]; then
    echo "{BOLD}${ORANGE}Aktualizuję repo ${RED}LIBERAL ARTIST ${RESET}"
    cd /home/piotr/gitlab/liberal_artist_org 
    git pull
    echo
    fi

if [ -d "/home/piotr/gitlab/py-exercises" ]; then
    echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}PY-EXERCISES ${RESET}"
    cd /home/piotr/gitlab/py-exercises
    git pull
    echo
    fi

if [ -d "/home/piotr/suckless/st" ]; then
    echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}SUCKLESS TERMINAL ${RESET}"
    cd /home/piotr/suckless/st
    git pull
    echo
    fi

if [ -d "/home/piotr/github/emacs-htmlize" ]; then
    echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}EMACS: htmlize ${RESET}"
    cd /home/piotr/github/emacs-htmlize
    git pull
    echo
    fi

. ~/.bashrc

