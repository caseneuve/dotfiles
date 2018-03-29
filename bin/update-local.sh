#!/bin/bash

# Path:        ~/.dotfiles/bin/update-local.sh
# Created:     22.03.18, 23:21    @manjaroi3
# Last update: 29.03.18, 02:29:52 @manjaroi3

# Doc: tymczasowe apdejty

package=fzf

if pacman -Qi $package &> /dev/null ; then
    echo "Paczka $(pacman -Q $package) jest zainstalowana, znajdziesz ją tu: $(which $package)" 
else
    echo "Instaluję `fuzzy findera`"
    sudo packman -S --noconfirm $package
fi

# archiwizuję: 29/03/2018
# file8=$HOME/.config/hangups/hangups.conf
# sym8=$HOME/.dotfiles/hangups.conf
# hdir=$HOME/.config/hangups

# printf ">> Sprawdzam, czy istnieje powiązanie do pliku: $sym8\n"
# if ! [ -d $hdir ]; then
#     mkdir $hdir
#     echo ">> Utworzyłem folder: $hdir."
# else
#     echo ">> Folder: $hdir istnieje."
# fi

# if ! [ -L $file8 ]; then
#     rm $file8
#     ln -s $sym8 $hdir
#     echo ">> Utworzyłem symlink do: $sym8."
# else
#     echo ">> Symlink istnieje."
# fi
    
