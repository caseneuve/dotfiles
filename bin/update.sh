# ~/.dotfiles/bin/update.sh
# Created:     15.01.18, 13:14    @x200
# Last update: 16.01.18, 10:19:24 @x200

# Doc: updates symbolic links

#!/bin/bash
file1=$HOME/.dotfiles/mutt/listenaudio.sh
sym1=$HOME/.mutt/listenaudio.sh
file2=$HOME/.dotfiles/mutt/goobook.sh
sym2=$HOME/.mutt/goobook.sh
mdir=$HOME/.mutt/


# check if files are updated from git
#$HOME/.dotfiles/bin/gitpull.sh

# check symlink mutt/listenaudio
if ! [ -L $mdir/listenaudio.sh ]; then
    echo "Tworzę symlink dla $file1."
    ln -s $file1 $mdir
    echo "...OK!"
else
    echo "Plik $sym1 już istnieje."
fi

# check symlink mutt/goobook
if ! [ -L $sym2 ]; then
    echo "Tworzę symlink dla $file2."
    ln -s $file2 $mdir
    echo "...OK!"
else
    echo "Plik $sym2 już istnieje."
fi

echo "Sprawdzam, czy goobook jest zainstalowany:"
/home/piotr/.dotfiles/Boot-ex/goobook.sh

echo "...OK!"
