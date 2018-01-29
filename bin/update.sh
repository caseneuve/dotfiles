# ~/.dotfiles/bin/update.sh
# Created:     15.01.18, 13:14    @x200
# Last update: 28.01.18, 16:26:45 @x200

# Doc:
# - updates symbolic links for mutt
# - installes ditaa, R

#!/bin/bash
file1=$HOME/.dotfiles/mutt/listenaudio.sh
sym1=$HOME/.mutt/listenaudio.sh
file2=$HOME/.dotfiles/mutt/goobook.sh
sym2=$HOME/.mutt/goobook.sh
mdir=$HOME/.mutt/


# check if files are updated from git
#$HOME/.dotfiles/bin/gitpull.sh

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

echo "Sprawdzam paczki..."
/home/piotr/.dotfiles/Boot-ex/goobook.sh

# zainstaluj ditaa i R
for package in ditaa r          
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

