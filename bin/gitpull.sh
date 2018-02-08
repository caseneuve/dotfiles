#!/bin/bash

# ~/.dotfiles/bin/gitpull.sh
# Created:     21.12.17           ?
# Last update: 08.02.18, 00:50:41 @lenovo

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

. ~/.bashrc

