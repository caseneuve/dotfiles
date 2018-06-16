#!/bin/bash

# Path:        $dotbin/config-after-clone.sh
# Created:     16.06.18, 21:07    @lenovo
# Last update: 16.06.18, 23:25:11 @lenovo

# Doc: After cloning repo /dotfiles, set all necessary symlinks for the system to work properly

## CONF DIRS
# general variables
dot="$HOME/.dotfiles"

# list of dirs to make
dirs="/.i3 /.config /.config/rofi /.config/qutebrowser /.config/hangups /.config/ranger /.config/neofetch /.config/feh /attachments /pdf /.mutt /.mutt/schemes /.bin /.tmux /.tmux/plugins /.fzf /suckcless /.newsboat /.calcurse /.moc /.moc/themes /Szkoła /Wideo/qtb /Muzyka/qtb"

# make sure this will be logged
logf=$HOME/.config-after-clone-log.txt
if [ ! -f "$logf" ]; then
    touch $logf && echo "# file created: $(date +%d.%m.%Y,%H:%M:%S)" > $logf
else
    echo "$(date +%d.%m.%Y,%H:%M:%S)" >> $logf
fi

# make the directories 
for x in $dirs; do
    if [ ! -d "$HOME$x" ]; then
        mkdir $HOME$x && echo "Tworzę $HOME$x" >> $logf
    else
        echo "$HOME$x już istnieje" >> $logf
    fi
done

## SYMLINKS
# i3
loc=$HOME/.i3/config
cfg=$dot/i3/config
tosh=$dot/i3/toshiba-conf
cp "$cfg" "$loc"
echo "# Last append: $(date '+%d.%m.%y, %H:%M:%S') @$HOSTNAME" >> "$loc"
cat "$tosh" >> "$loc"

cd ~/.i3
ln -s $dot/i3/i3blocks.conf $HOME/.i3

# ranger
cd $HOME/.config/ranger
rm *
rfiles="commands.py rc.conf rifle.conf scope.sh"
for x in $rfiles; do
    ln -s $dot/ranger/$x .
done

# mutt
cd $HOME
if [ -f .muttrc ]; then
    rm .muttrc
fi

ln -s $dot/mutt/muttrc $HOME/.muttrc

cd $HOME/.mutt
muttfiles="goobook.sh kbd.conf listenaudio.sh mailcap viewimagefeh.sh viewpdf.sh"

for x in $muttfiles; do
    ln -s $dot/mutt/$x .
done

# tmux
ln -s $dot/tmux.conf $HOME/.tmux.conf

# moc
cd $HOME/.moc
mocfiles="config keymap"

for x in $mocfiles; do
    ln -s $dot/moc/$x .
done

ln -s $dot/moc/my_theme ./themes/

# newsboat
cd $HOME/.newsboat
ln -s $dot/newsboat/config .
ln -s $HOME/Dropbox/config/newsboat/urls .

# calcurse
cd $HOME/.calcurse
ln -s $dot/calcurse/conf .
ln -s $dot/calcurse/keys .
ln -s $HOME/Dropbox/config/.apts $HOME/.calcurse/apts

# feh
cd $HOME/.config/feh
ln -s $dot/feh/keys .

# qutebrowser
cd $HOME/.config/qutebrowser
ln -s $dot/qtbro/config.py .
ln -s $HOME/Dropbox/config/qutebrowser/quickmarks .

