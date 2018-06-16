#!/bin/bash

# Path:        ~/.dotfiles/bin/auto-config/clone-repos.sh
# Created:     16.06.18, 22:21    @lenovo
# Last update: 16.06.18, 23:52:13 @lenovo

# Doc: After cloning /dotfiles repo, execute this script to clone other repositories; NOTE: ~git~ package has to be installed 

# emacs
git clone https://github.com/caseneuve/emacs /home/piotr/.emacs.git
cd /home/piotr/.emacs.git
ln -s /home/piotr/.emacs.git/.emacs /home/piotr/.emacs

