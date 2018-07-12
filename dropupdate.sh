#!/bin/bash

# Path:        ~/.dotfiles/dropupdate.sh
# Created:     11.07.18, 18:01    @x200
# Last update: 12.07.18, 19:03:59 @x200

# Doc:
# todo: zainstalować sysstat @toshiba
# note: sync :
# - /home/piotr/box/Dropbox/.Config
# - /home/piotr/box/Dropbox/Dokumenty/
# - /box/Dropbox/Szkoła/2017-2018/

# rename existing dirs
mv ~/Pobrane ~/dwl 
mv ~/Wideo ~/wid
mv ~/Obrazy ~/obr
mv ~/attachments ~/dwl/att

# make dirs
mkdir -p box dox/org git/lab git/hub szk szk/2017-2018 bin 

# make hard links
ln /home/piotr/box/Dropbox/.Config/Qutebrowser/urls                 ~/.config/qutebrowser 
ln /home/piotr/box/Dropbox/.Config/Qutebrowser/quickmarks           ~/.config/qutebrowser/bookmarks
ln /home/piotr/box/Dropbox/.Config/Calcurse/.apts                   ~/.calcurse/apts
ln /home/piotr/box/Dropbox/.Config/Newsboat/urls                    ~/.newsboat
ln /home/piotr/box/Dropbox/Dokumenty/Notatki/quicknotes.txt         ~/dox/org/quicknotes.txt
ln /home/piotr/box/Dropbox/.Config/Emacs/abbrev_defs                ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/bookmarks                  ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/client-dark-theme.el       ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/leuven-deluxe-theme.el     ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/misterioso-deluxe-theme.el ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/init.el                    ~/.emacs.d
ln /home/piotr/box/Dropbox/.Config/Emacs/init.org                   ~/.emacs.d
ln ~/box/Dropbox/Szkoła/2017-2018/lekcje/dialektyka17-18.org        ~/szk/dialektyka.org 
ln ~/box/Dropbox/Szkoła/2017-2018/lekcje/retoryka17-18.org          ~/szk/retoryka.org  
ln ~/box/Dropbox/Szkoła/2017-2018/lekcje/filozofia17-18.org         ~/szk/filozofia.org 
ln ~/box/Dropbox/Szkoła/2017-2018/lekcje/filozofia17-18.org         ~/szk/filozofia.org 
ln ~/box/Dropbox/Szkoła/2017-2018/lekcje/gramatyka17-18.org         ~/szk/gramatyka.org
ln ~/box/Dropbox/Szkoła/2017-2018/szkoła17-18.org                   ~/szk/szkoła.org

# make symlinks
ln -s /home/piotr/box/Dropbox/Dokumenty/Komputer/arch-log           ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Gtd/log.org                 ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Gtd/notes.org               ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Oikonomia/oikonomia2018.org ~/dox/org

# let Slack do not make ~/Downloads folder at start
slackfile=~/.config/Slack/storage/slack-settings
[[ -f $slackfile ]] && sed -i 's/\/home\/piotr\/Downloads/\/home\/piotr\/dwl/g' $slackfile


