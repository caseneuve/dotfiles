#!/bin/bash

# Path:        ~/.dotfiles/bin/update-local.sh
# Created:     22.03.18, 23:21    @manjaroi3
# Last update: 22.03.18, 23:35:05 @manjaroi3

# Doc: tymczasowe apdejty

file8=$HOME/.config/hangups/hangups.conf
sym8=$HOME/.dotfiles/hangups.conf
hdir=$HOME/.config/hangups

printf ">> Sprawdzam, czy istnieje powiązanie do pliku: $sym8\n"
if ! [ -d $hdir ]; then
    mkdir $hdir
    echo ">> Utworzyłem folder: $hdir."
else
    echo ">> Folder: $hdir istnieje."
fi

if ! [ -L $file8 ]; then
    rm $file8
    ln -s $sym8 $hdir
    echo ">> Utworzyłem symlink do: $sym8."
else
    echo ">> Symlink istnieje."
fi
    
