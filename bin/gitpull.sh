#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 25.08.18, 19:22:28 @toshiba

# Doc:
# Aktualizuje repozytoria 'dotfiles', 'emacs/load' oraz wspólny projekt z gitlaba  na lokalnym komputerze
# TODO: loop?

# colors
ORANGE="$(tput setaf 11)"
RED="$(tput setaf 9)"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"

DOTFILES=/home/piotr/.dotfiles
EMACS=/home/piotr/.emacs.git
#ARTIST=/home/piotr/git/lab/liberal_artist_org
PY_EX=/home/piotr/git/lab/py-exercises
ST=/home/piotr/git/hub/st
EMACS_HTMLIZE=/home/piotr/git/hub/emacs-htmlize

clear

echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}DOTFILES ${RESET}"
cd $DOTFILES
git pull 
echo

echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}EMACS ${RESET}"
cd $EMACS 
git pull 
echo

# if [ -d $ARTIST ]; then
#     echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}LIBERAL ARTIST ${RESET}"
#     cd $ARTIST 
#     git pull
#     echo
# fi

if [ -d $PY_EX ]; then
    echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}PY-EXERCISES ${RESET}"
    cd $PY_EX
    git pull
    echo
fi

if [ -d $ST ]; then
    echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}SUCKLESS TERMINAL ${RESET}"
    cd $ST
    git pull
    echo
fi

if [ -d $EMACS_HTMLIZE ]; then
    echo "${BOLD}${ORANGE}Aktualizuję repo ${RED}EMACS: htmlize ${RESET}"
    cd $EMACS_HTMLIZE
    git pull
    echo
fi

. ~/.bashrc

