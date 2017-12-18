#!/bin/bash

cd /home/piotr/.dotfiles/
if [[ `git status --porcelain` ]]; then
    /home/piotr/.bin/gitpush.sh && \
    while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Tt]* ) systemctl suspend;;
        [Nn]* ) exit;;
        * ) echo "Please answer T or N.";;
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
