#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 25.08.18, 19:29:37 @toshiba

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
PY_EX=/home/piotr/git/lab/py-exercises
ST=/home/piotr/git/hub/st
EMACS_HTMLIZE=/home/piotr/git/hub/emacs-htmlize
#ARTIST=/home/piotr/git/lab/liberal_artist_org

clear

for i in $DOTFILES $EMACS $PY_EX $ST $EMACS_HTMLIZE
do
    if [[ -d $i ]]; then
        echo "## Aktualizuję repo $i"
        cd $i
        git pull
        echo
    else
        echo -e "!! Nie ma takiego repo:\n$i"
    fi
done

. ~/.bashrc

