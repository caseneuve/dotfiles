#!/bin/bash

cd /home/piotr/.dotfiles/
if [[ `git status --porcelain` ]]; then
    /home/piotr/.bin/gitpush.sh && \
    while true; do
    read -p "Czy chcesz wyłączyć komputer? [t/n] " yn
    case $yn in
        [Tt]* ) systemctl suspend;;
        [Nn]* ) exit;;
        * ) echo "Wpisz [Tt/Nn] :";;
    esac
done   
 
else
    echo "Do you wish to install this program?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) systemctl suspend;;
            No ) exit;;
        esac
    done 
fi
