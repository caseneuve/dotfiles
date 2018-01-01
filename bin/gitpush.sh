# ~/.dotfiles/bin/asdf.sh
# Created:     27.12.17           ?
# Last update: 01.01.18, 11:54:01 @manjaroi3

# Doc:
#
# Wysyła zmiany do repo 'dotfiles' i 'emacs' na githubie
# https://stackoverflow.com/questions/5143795/how-can-i-check-in-a-bash-script-if-my-local-git-repo-has-changes

#!/bin/bash

# variables
bold=$(tput bold)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

# repo DOTFILES

echo "Aktualizuję repo DOTFILES:"
echo "=========================="
cd /home/piotr/.dotfiles
if [ -z "$(git status --porcelain)" ]; then
    echo "Git jest aktualny.";
else
    git add . && \
    git add -u && \
    read -p "${cyan}${bold}Opis commita: ${reset}" opis && \
    git commit -m "$opis" && \
    git push
fi
printf "\n"

# repo EMACS
echo "Aktualizuję repo EMACS:"
echo "=========================="
cd /home/piotr/.emacs.d/load
if [ -z "$(git status --porcelain)" ]; then
    echo "Git jest aktualny.";
else
    git add . && \
    git add -u && \
    read -p "${cyan}${bold}Opis commita: ${reset}" opis && \
    git commit -m "$opis" && \
    git push
fi

printf "\n"
echo "... zrobione!"
