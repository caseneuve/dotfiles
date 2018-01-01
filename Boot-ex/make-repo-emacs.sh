# ~/.dotfiles/Boot-ex/make-repo-emacs.sh
# Created:     01.01.18, 11:58    @manjaroi3
# Last update: 01.01.18, 12:10:38 @lenovo

# Doc: clone repo /emacs to ~/.emacs.d/load

#!/bin/bash

# vars
dir=$HOME/.emacs.d/load

echo "Kopiuję repo EMACS do katalogu $dir"

if [ -d "$dir" ]; then
    rm -r $dir
fi

git clone https://github.com/caseneuve/emacs $dir
echo "...ok!"
printf "\n"

echo "$(cd $dir; pwd; ls -l)"
echo "...zrobione!"

