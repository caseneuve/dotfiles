#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 03.09.18, 09:03:00 @lenovo

# Doc:
# Aktualizuje repozytoria 'dotfiles', 'emacs/load' oraz wspólny projekt z gitlaba  na lokalnym komputerze
# TODO: loop?

# colors
# ORANGE="$(tput setaf 11)"
# RED="$(tput setaf 9)"
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
        echo "## Aktualizuję repo $BOLD$(basename $i)$RESET:"
        cd $i
        [[ $(git branch | grep "\* patched") ||  $(git branch | grep "\* master") ]] && git branch | grep "\*" || git checkout master
        git status --porcelain
        git pull
        echo
    else
        echo -e "!! Nie ma takiego repo:\n$i\n"
    fi
done

. ~/.bashrc

