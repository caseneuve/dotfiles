#!/bin/bash

bold=$(tput bold)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

cd /home/piotr/.dotfiles && \

if git diff-index --quiet HEAD --; then
    echo "Git jest aktualny.";
else
    git add . && \
    git add -u && \
    read -p "${cyan}${bold}Opis commita: ${reset}" opis && \
    git commit -m "$opis" && \
    git push
fi

# https://stackoverflow.com/questions/5143795/how-can-i-check-in-a-bash-script-if-my-local-git-repo-has-changes
