#!/bin/bash

# Path:        ~/.dotfiles/dropupdate.sh
# Created:     11.07.18, 18:01    @x200
# Last update: 12.07.18, 01:11:50 @x200

# Doc:
# todo: zainstalować sysstat @toshiba

mv ~/Pobrane ~/dwl 
mv ~/Wideo ~/wid
mv ~/Obrazy ~/obr
mv ~/attachments ~/dwl/att

mkdir -p box dox/org git/lab git/hub szk szk/2017-2018 bin 

ln /home/piotr/box/Dropbox/.Config/Calcurse/.apts                   ~/.calcurse/apts
ln /home/piotr/box/Dropbox/.Config/Newsboat/urls                    ~/.newsboat
ln /home/piotr/box/Dropbox/Dokumenty/Notatki/quicknotes.txt         ~/dox/org/quicknotes.txt
ln /home/piotr/box/Dropbox/.Config/Emacs/abbrev_defs                ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/bookmarks                  ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/client-dark-theme.el       ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/leuven-deluxe-theme.el     ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/misterioso-deluxe-theme.el ~/.emacs.d
ln -s /home/piotr/box/Dropbox/Dokumenty/Komputer/arch-log           ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Gtd/log.org                 ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Gtd/notes.org               ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Oikonomia/oikonomia2018.org ~/dox/org

