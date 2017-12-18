#!/bin/bash

bold=$(tput bold)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

cd /home/piotr/.dotfiles &&\
git add . && \
git add -u && \
read -p "${cyan}${bold}Opis commita: ${reset}" opis && \
git commit -m "$opis" &&\
git push
