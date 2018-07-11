#!/bin/bash

# Path:        ~/.dotfiles/dropupdate.sh
# Created:     11.07.18, 18:01    @x200
# Last update: 11.07.18, 18:16:08 @x200

# Doc:

mv ~/Pobrane ~/dwl 
mv ~/Wideo ~/wid
mv ~/Obrazy ~/obr
mv ~/attachments ~/dwl/att

mkdir -p box dox/org git/lab git/hub szk szk/2017-2018 bin 

ln /home/piotr/box/Dropbox/.Config/Calcurse/.apts ~/.calcurse/apts
ln /home/piotr/box/Dropbox/.Config/Newsboat/urls ~/.newsboat
ln /home/piotr/box/Dropbox/Dokumenty/Notatki/quicknotes.txt ~/dox/org/quicknotes.txt
ln 
