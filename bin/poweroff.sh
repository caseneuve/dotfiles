#!/bin/bash

cd /home/piotr/.dotfiles/
if [[ `git status --porcelain` ]]; then
    /home/piotr/.bin/gitpush.sh && \
    systemctl suspend
else
    echo "Do you wish to install this program?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) systemctl suspend;;
            No ) exit;;
        esac
    done 
fi
