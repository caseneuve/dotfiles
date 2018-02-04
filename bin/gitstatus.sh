# ~/.dotfiles/bin/asdf.sh
# Created:     27.12.17           ?
# Last update: 04.02.18, 20:52:37 @x200

# Doc:
#
# Podaje status repozytoriów 'dotfiles' i 'emacs' na lokalnym komputerze

#!/bin/bash

# variables
YEL=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)
bold=$(tput bold)

echo "Sprawdzam status repo DOTFILES:"
echo "==============================="
cd /home/piotr/.dotfiles/
if [[ `git status --porcelain` ]]; then
    printf "${YEL}${bold}Git status - masz do opublikowania następujące zmiany:${RESET}\n$(git status --porcelain)\n"
#-----------------------------------------------------\n\n$(git diff --cached)\n" 
else
    git status
fi
printf "\n"

echo "Sprawdzam status repo EMACS:"
echo "============================"
cd /home/piotr/.emacs.git
if [[ `git status --porcelain` ]]; then
    printf "${YEL}${bold}Git status - masz do opublikowania następujące zmiany:${RESET}\n$(git status --porcelain)\n"
#-----------------------------------------------------\n\n$(git diff --cached)\n" 
else
    git status
fi
printf "\n"

echo "Sprawdzam status repo LIBERAL ARTIST:"
echo "==============================="
cd /home/piotr/gitlab/liberal_artist_org
if [[ `git status --porcelain` ]]; then
    printf "${YEL}${bold}Git status - masz do opublikowania następujące zmiany:${RESET}\n$(git status --porcelain)\n"
#-----------------------------------------------------\n\n$(git diff --cached)\n" 
else
    git status
fi

