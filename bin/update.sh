#!/bin/bash

# ~/.dotfiles/bin/update.sh
# Created:     15.01.18, 13:14    @x200
# Last update: 30.01.18, 20:30:56 @manjaroi3

# Doc:
# - updates symbolic links for mutt and ranger (scope.sh)
# - installes ditaa, R, gnome-calc, docx2txt, unrtf

# Status:
# todo: wydzielić instalowanie paczek do innego skryptu

# CSH:

# variables
file1=$HOME/.dotfiles/mutt/listenaudio.sh
sym1=$HOME/.mutt/listenaudio.sh
file2=$HOME/.dotfiles/mutt/goobook.sh
sym2=$HOME/.mutt/goobook.sh
mdir=$HOME/.mutt/
file3=$HOME/.dotfiles/ranger/scope.sh
sym3=$HOME/.config/ranger/scope.sh
bak=$HOME/.config/bak/

# check symlink mutt/listenaudio
printf "Sprawdzam, czy istnieje link do skryptu:\n$file1...\n"
if ! [ -L $mdir/listenaudio.sh ]; then
    echo "Tworzę symlink dla $file1."
    ln -s $file1 $mdir
    echo "...OK!"
else
    echo "...OK!"
fi

# check symlink mutt/goobook
printf "Sprawdzam, czy istnieje link do skryptu:\n$file2...\n"
if ! [ -L $sym2 ]; then
    echo "Tworzę symlink dla $file2."
    ln -s $file2 $mdir
    echo "...OK!"
else
    echo "...OK!"
fi

# check symlink ranger/scope.sh
printf "Sprawdzam, czy istnieje link do skryptu:\n$file3...\n"
if ! [ -L $sym3 ]; then
    if [ -d $bak ]; then
        mv $file3 $bak
    else
        mkdir $bak
        mv $file3 $bak
    fi
    echo "Tworzę symlink dla $file3."
    ln -s $file3 $sym3
    echo "...OK!"
else
    echo "...OK!"
fi


# check if packages are installed
echo "Sprawdzam paczki..."
/home/piotr/.dotfiles/Boot-ex/goobook.sh

# zainstaluj brakujące paczki
for package in ditaa r gnome-calculator unrtf docx2txt calcurse
do
if pacman -Qi $package &> /dev/null ; then
  echo "Paczka $(pacman -Q $package) jest zainstalowana." 
else
    echo "Instaluję $package..."
    sudo pacman -S --noconfirm $package;
    echo "Paczka $(pacman -Q $package) została zainstalowana."
fi
done

echo "...OK!"

