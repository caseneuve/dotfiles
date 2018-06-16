#!/bin/bash

# Path:        ~/.dotfiles/bin/auto-config/clone-repos.sh
# Created:     16.06.18, 22:21    @lenovo
# Last update: 17.06.18, 00:15:08 @lenovo

# Doc: After cloning /dotfiles repo, execute this script to clone other repositories; NOTE: ~git~ package has to be installed 

# emacs
git clone https://github.com/caseneuve/emacs /home/piotr/.emacs.git
cd /home/piotr/.emacs.git
if [ -f /home/piotr/.emacs ]; then
    rm /home/piotr/.emacs
    cp /home/piotr/.emacs.git/.emacs /home/piotr/.emacs
fi

cd /home/piotr/.emacs.d
touch custom.el
ln -s /home/piotr/Dropbox/EMACS/.load/misterioso-deluxe-theme.el .
ln -s /home/piotr/Dropbox/EMACS/.load/leuven-deluxe-theme.el .
ln -s /home/piotr/Dropbox/EMACS/.load/client-dark-theme.el .

