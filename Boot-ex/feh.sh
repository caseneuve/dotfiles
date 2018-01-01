# ~/.dotfiles/Boot-ex/feh.sh
# Created:     01.01.18, 16:47    @x200
# Last update: 01.01.18, 17:16:35 @lenovo

# Doc: Symlink feh keys file to dotfiles

#!/bin/bash

# vars
package=feh
dir=$HOME/.config/feh
bak=$HOME/.config/feh/bak
file=$HOME/.dotfiles/feh/keys

# sprawdź czy feh jest w ogóle zainstalowany
if pacman -Qi $package &>/dev/null; then
    echo "Sprawdzam, czy paczka $package jest zainstalowana..."
    echo "... ok!"
else
    echo "Paczka $package nie jest zainstalowana, instaluję."
    sudo pacman -S --noconfirm $package &&\
        echo "Zainstalowałem paczkę $(pacman -Q $package)."
    pirnt "\n"
fi

# sprawdź czy istnieje folder ~/.config/feh i zrób tam porządek 
echo "Czyszczę $dir"

if [ -d $dir ]; then
    mkdir -p $bak
    mv $dir/* $bak
else
    mkdir -p $dir
fi

echo "... ok!"

# utwórz symlink 
echo "Tworzę symlink do $file"
ln -s $file $dir
echo "... ok!"
echo "Check:"
echo "$(cd $dir; pwd; ls -l)"
printf "\n"





