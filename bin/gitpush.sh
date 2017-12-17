#!/bin/bash

cd /home/piotr/.dotfiles &&\
git add . && \
git add -u && \
read -p "Opis commita: " opis && \
git commit -m "$opis" &&\
git push
