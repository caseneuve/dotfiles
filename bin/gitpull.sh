#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 06.11.18, 00:11:46 @toshiba

# Doc:
# Aktualizuje repozytoria 'dotfiles', 'emacs/load' oraz wspólny projekt z gitlaba  na lokalnym komputerze
# TODO: loop?

# colors
# ORANGE="$(tput setaf 11)"
# RED="$(tput setaf 9)"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"

DOTFILES=/home/piotr/.dotfiles
EMACS=/home/piotr/git/hub/emacs
HOBBIT=/home/piotr/git/hub/hobbit
HEDER=/home/piotr/git/hub/heder
PY_EX=/home/piotr/git/lab/py-exercises
ST=/home/piotr/git/hub/st
SZK=/home/piotr/git/lab/szk.el
I3=/home/piotr/git/hub/i3
EMACS_HTMLIZE=/home/piotr/git/hub/emacs-htmlize

clear

for i in $DOTFILES $I3 $EMACS $HOBBIT $HEDER $SZK $ST $EMACS_HTMLIZE $PY_EX 
do
    if [[ -d $i ]]; then
        echo "## Aktualizuję repo $BOLD$(basename $i)$RESET:"
        cd $i
        # [[ $(git branch | grep "\* patched") ||  $(git branch | grep "\* master") ]] && git branch | grep "\*" || git checkout master
        git status --porcelain
        git pull --all
        echo
    else
        echo -e "!! Nie ma takiego repo:\n$i\n"
    fi
done

. ~/.bashrc

