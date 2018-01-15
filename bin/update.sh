# ~/.dotfiles/bin/update.sh
# Created:     15.01.18, 13:14    @x200
# Last update: 15.01.18, 13:23:00 @x200

# Doc: updates symbolic links

#!/bin/bash
file1=$HOME/.dotfiles/mutt/listenaudio.sh
file2=$HOME/.dotfiles/mutt/goobook.sh
mdir=$HOME/.mutt/

$HOME/.dotfiles/bin/gitpull.sh
echo "Tworzę symlink dla $file1"
ln -s $file1 $mdir
echo "...OK!"
echo "Tworzę symlink dla $file2"
ln -s $file2 $mdir
echo "...OK!"
