#!/bin/bash

YEL=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)
bold=$(tput bold)

cd /home/piotr/.dotfiles/
if [[ `git status --porcelain` ]]; then
    clear
    printf "${YEL}${bold}Git status - masz do opublikowania następujące zmiany:${RESET}\n$(git status --porcelain)\n-----------------------------------------------------\n\n$(git diff --cached)\n" 
else
    git status
fi

