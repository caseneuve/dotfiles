# ~/.dotfiles/bin/asdf.sh
# Created:     21.12.17           ?
# Last update: 01.01.18, 11:45:31 @manjaroi3

# Doc:
#
# Aktualizuje repozytoria 'dotfiles' i 'emacs/load' na lokalnym komputerze

#!/bin/bash

echo "Aktualizuję repo .dotfiles"
cd /home/piotr/.dotfiles 
git pull
echo "... ok!"

echo "Aktualizuję repo .emacs.d/load"
cd /home/piotr/.emacs.d/load 
git pull
echo "... ok!"
