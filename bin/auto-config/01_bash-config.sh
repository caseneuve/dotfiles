#!/bin/bash

# Path:        ~/.dotfiles/bin/auto-config/bash-config.sh
# Created:     16.06.18, 21:32    @lenovo
# Last update: 16.06.18, 23:50:12 @lenovo

# Doc: When repo /dotfiles is cloned, symlink bash files

dot="/home/piotr/.dotfiles/"
files="bashrc bash_aliases"

for x in $files; do
    if [ -f "$dot/$x" ] && [ ! -L "/home/piotr/.$x" ]; then
        cd /home/piotr
        rm ".$x"
        ln -s "$dot/$x" "/home/piotr/.$x"
    else
        echo "/home/piotr/.$x is already linked!"
    fi
done

. /home/piotr/.bashrc

