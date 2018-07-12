#!/bin/bash

# Path:        ~/.dotfiles/dropupdate.sh
# Created:     11.07.18, 18:01    @x200
# Last update: 12.07.18, 21:39:28 @x200

# Doc:
# note: sync :
# - /home/piotr/box/Dropbox/.Config
# - /home/piotr/box/Dropbox/Dokumenty/
# - /box/Dropbox/Szkoła/2017-2018/

GREEN="$(tput setaf 2)"
ORANGE="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
CYAN="$(tput setaf 6)"
RED="$(tput setaf 9)"
MAGENTA="$(tput setaf 13)"
BOLD="$(tput bold)"
RESET="$(tput sgr0)"

echo "$BLUE$BOLD >>> instaluję paczki...$RESET"
# install apps
for n in dunst xdotool sysstat; do
    if ! pacman -Qi $n &>/dev/null; then
        sudo pacman -S --noconfirm $n
    fi
done

echo -e "\n$ORANGE$BOLD >>> tworzę foldery... $RESET "
# make dirs
mkdir -p ~/box ~/dox/org ~/git/lab ~/git/hub ~/szk/2017-2018 ~/bin ~/dwl ~/wid ~/obr ~/bak/scr ~/.config/dunst

echo -e "\n$GREEN$BOLD >>> zmieniam nazwy istniejących folderówtworzę foldery... $RESET "
# rename existing dirs
mv ~/Pobrane ~/dwl 
mv ~/Wideo ~/wid
mv ~/Obrazy ~/obr
mv ~/attachments ~/dwl/att

echo -e "\n$MAGENTA$BOLD >>> przenoszę zawartość .bin/bin... $RESET "
[[ -d ~/.bin ]] && mv ~/.bin/* ~/bak/scr
[[ -d ~/bin ]] && mv ~/bin/* ~/bak/scr

echo -e "\n$RED$BOLD >>> usuwam stare symlinki... $RESET"
# remove old symlinks
rm ~/.config/qutebrowser/urls
rm ~/.config/qutebrowser/bookmarks
rm ~/.calcurse/apts
rm ~/.newsboat/urls
rm ~/.emacs.d/client-dark-theme.el
rm ~/.emacs.d/leuven-deluxe-theme.el
rm ~/.emacs.d/misterioso-deluxe-theme.el

echo -e "\n$CYAN$BOLD >>> tworzę nowe hard/sym-linki... $RESET"
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
ln ~/.dotfiles/dunstrc                                              ~/.config/dunst

ln ~/.dotfiles/bin/* ~/bin

# make symlinks
ln -s /home/piotr/box/Dropbox/Dokumenty/Komputer/arch-log           ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Gtd/log.org                 ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Gtd/notes.org               ~/dox/org
ln -s /home/piotr/box/Dropbox/Dokumenty/Oikonomia/oikonomia2018.org ~/dox/org

echo -e "\n$BOLD Zmieniam konfig dla slacka...$RESET"
# let Slack do not make ~/Downloads folder at start
slackfile=~/.config/Slack/storage/slack-settings
[[ -f $slackfile ]] && sed -i 's/\/home\/piotr\/Downloads/\/home\/piotr\/dwl/g' $slackfile

