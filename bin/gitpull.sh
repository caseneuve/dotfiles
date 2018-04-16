#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 16.04.18, 16:23:24 @manjaroi3

# Doc:
#
# Aktualizuje repozytoria 'dotfiles', 'emacs/load' oraz wspólny projekt z gitlaba  na lokalnym komputerze

echo "Aktualizuję repo DOTFILES:"
cd /home/piotr/.dotfiles 
git pull
echo -e "... ok!\n"

echo "Aktualizuję repo EMACS:"
cd /home/piotr/.emacs.git 
git pull
echo -e "... ok!\n"

if [ -d "/home/piotr/gitlab/liberal_artist_org" ]; then
    echo "Aktualizuję repo LIBERAL ARTIST:"
    cd /home/piotr/gitlab/liberal_artist_org 
    git pull
    echo -e "... ok!\n"
fi

if [ -d "/home/piotr/suckless/st" ]; then
    echo "Aktualizuję repo SUCKLESS TERMINAL:"
    cd /home/piotr/suckless/st 
    git pull
    echo -e "... ok!\n"
fi

. ~/.bashrc

