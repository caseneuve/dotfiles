#!/bin/bash

# ~/.dotfiles/bin/asdf.sh
# Created:     27.12.17           ?
# Last update: 04.02.18, 20:51:37 @x200

# Doc:
#
# Wysyła zmiany do repo 'dotfiles' i 'emacs' na githubie
# https://stackoverflow.com/questions/5143795/how-can-i-check-in-a-bash-script-if-my-local-git-repo-has-changes

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
echo "======================="
cd /home/piotr/.emacs.git
# ustaw cache na 30 min. (timeout=sec.), exit: "git credential-cache exit"
git config credential.helper 'cache --timeout=1800'
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

# repo Liberal Artist @gitlab
echo "Aktualizuję repo LIBERAL ARTIST:"
echo "======================="
cd /home/piotr/gitlab/liberal_artist_org
# ustaw cache na 30 min. (timeout=sec.), exit: "git credential-cache exit"
git config credential.helper 'cache --timeout=1800'
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
