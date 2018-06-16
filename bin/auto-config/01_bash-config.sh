#!/bin/bash

# Path:        ~/.dotfiles/bin/auto-config/bash-config.sh
# Created:     16.06.18, 21:32    @lenovo
# Last update: 16.06.18, 23:47:47 @lenovo

# Doc: When repo /dotfiles is cloned, symlink bash files

dot="$HOME/.dotfiles/"
files="bashrc bash_aliases"

for x in $files; do
    if [ -f "$dot/$x" ] && [ ! -L "$HOME/.$x" ]; then
        cd $HOME
        rm ".$x"
        ln -s "$dot/$x" "$HOME/.$x"
    else
        echo "$HOME/.$x is already linked!"
    fi
done

. $HOME/.bashrc

