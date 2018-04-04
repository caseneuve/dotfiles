#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 04.04.18, 03:13:42 @x200

# Doc:
#
# Aktualizuje repozytoria 'dotfiles', 'emacs/load' oraz wspólny projekt z gitlaba  na lokalnym komputerze

echo "Aktualizuję repo DOTFILES:"
cd /home/piotr/.dotfiles 
git pull
echo "... ok!"
printf "\n"

echo "Aktualizuję repo EMACS:"
cd /home/piotr/.emacs.git 
git pull
echo "... ok!"
printf "\n"

if [ -d "/home/piotr/gitlab/liberal_artist_org" ]; then
    echo "Aktualizuję repo LIBERAL ARTIST:"
    cd /home/piotr/gitlab/liberal_artist_org 
    git pull
    echo "... ok!"
fi
printf "\n"

if [ -d "/home/piotr/suckless/st" ]; then
    echo "Aktualizuję repo SUCKLESS TERMINAL:"
    cd /home/piotr/suckless/st 
    git pull
    echo "... ok!"
fi

. ~/.bashrc

