#!/bin/bash

# Path:        ~/.dotfiles/bin/auto-config/clone-repos.sh
# Created:     16.06.18, 22:21    @lenovo
# Last update: 16.06.18, 22:28:15 @lenovo

# Doc: After cloning /dotfiles repo, execute this script to clone other repositories; NOTE: ~git~ package has to be installed 

# emacs
clone https://github.com/caseneuve/emacs $HOME/.emacs.git
cd $HOME/.emacs.git
ln -s $HOME/.emacs.git/.emacs $HOME/.emacs

