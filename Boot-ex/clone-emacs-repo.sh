# ~/.dotfiles/Boot-ex/make-repo-emacs.sh
# Created:     01.01.18, 11:58    @manjaroi3
# Last update: 01.01.18, 12:46:46 @manjaroi3

# Doc: clone repo /emacs to ~/.emacs.git

#!/bin/bash

# vars
dirold=$HOME/.emacs.d/load
dirgit=$HOME/.emacs.git
heder=$HOME/.emacs.git/pk-header-line.el
heder2=$HOME/.emacs.git/tweaks/pk-header-line.el

echo "Czyszczę katalog  $dirold"

if [ -d "$dirold" ]; then
    cd $dirold
    rm -rf *
fi

echo "...ok!"
printf "\n"

echo "Tworzę repo ~/.emacs.git"
git clone https://github.com/caseneuve/emacs $dirgit
echo "...ok!"
printf "\n"

echo "Tworzę symlink do pk-header-line.el"
cd $dirgit
mkdir -p tweaks
mv $heder $heder2
ln -s $heder2 $dirold
echo "...ok!"
printf "\n"

echo "Check:"
echo "$(cd $dirgit; pwd; ls -rl)"
echo "$(cd $dirold; pwd; ls -l)"
echo "...zrobione!"
