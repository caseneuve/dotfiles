# ~/.dotfiles/bin/asdf.sh
# Created:     21.12.17           ?
# Last update: 01.01.18, 12:24:38 @lenovo

# Doc:
#
# Aktualizuje repozytoria 'dotfiles' i 'emacs/load' na lokalnym komputerze

#!/bin/bash

echo "Aktualizuję repo DOTFILES:"
cd /home/piotr/.dotfiles 
git pull
echo "... ok!"
printf "\n"

echo "Aktualizuję repo EMACS:"
cd /home/piotr/.emacs.git 
git pull
echo "... ok!"
