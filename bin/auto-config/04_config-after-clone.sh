#!/bin/bash

# Path:        $dotbin/config-after-clone.sh
# Created:     16.06.18, 21:07    @lenovo
# Last update: 17.06.18, 00:52:17 @lenovo

# Doc: After cloning repo /dotfiles, set all necessary symlinks for the system to work properly

## CONF DIRS
# general variables
dot="/home/piotr/.dotfiles"

# list of dirs to make
dirs="/.i3 /.config /.config/rofi /.config/qutebrowser /.config/qutebrowser/bookmarks /.config/hangups /.config/ranger /.config/neofetch /.config/feh /attachments /pdf /.mutt /.mutt/schemes /.bin /.tmux /.tmux/plugins /.fzf /suckcless /.newsboat /.calcurse /.moc /.moc/themes /Szkoła /Wideo/qtb /Muzyka/qtb"

# make sure this will be logged
logf=/home/piotr/.config-after-clone-log.txt
if [ ! -f "$logf" ]; then
    touch $logf && echo "# file created: $(date +%d.%m.%Y,%H:%M:%S)" > $logf
else
    echo "$(date +%d.%m.%Y,%H:%M:%S)" >> $logf
fi

# make the directories 
for x in $dirs; do
    if [ ! -d "/home/piotr$x" ]; then
        mkdir /home/piotr$x && echo "Tworzę /home/piotr$x" >> $logf
    else
        echo "/home/piotr$x już istnieje" >> $logf
    fi
done

## SYMLINKS
# i3
loc=/home/piotr/.i3/config
cfg=$dot/i3/config
tosh=$dot/i3/toshiba-conf
cp "$cfg" "$loc"
echo "# Last append: $(date '+%d.%m.%y, %H:%M:%S') @$HOSTNAME" >> "$loc"
cat "$tosh" >> "$loc"

cd ~/.i3
ln -s $dot/i3/i3blocks.conf /home/piotr/.i3

# ranger
cd /home/piotr/.config/ranger
rm *
rfiles="commands.py rc.conf rifle.conf scope.sh"
for x in $rfiles; do
    ln -s $dot/ranger/$x .
done

# mutt
cd /home/piotr
if [ -f .muttrc ]; then
    rm .muttrc
fi

ln -s $dot/mutt/muttrc /home/piotr/.muttrc

cd /home/piotr/.mutt
muttfiles="goobook.sh kbd.conf listenaudio.sh mailcap viewimagefeh.sh viewpdf.sh"

for x in $muttfiles; do
    ln -s $dot/mutt/$x .
done

cd /home/piotr/.mutt/schemes
ln -s $dot/mutt/mutt_color .

# tmux
ln -s $dot/tmux.conf /home/piotr/.tmux.conf

# moc
cd /home/piotr/.moc
mocfiles="config keymap"

for x in $mocfiles; do
    ln -s $dot/moc/$x .
done

ln -s $dot/moc/my_theme ./themes/

# newsboat
cd /home/piotr/.newsboat
ln -s $dot/newsboat/config .
ln -s /home/piotr/Dropbox/config/newsboat/urls .

# calcurse
cd /home/piotr/.calcurse
ln -s $dot/calcurse/conf .
ln -s $dot/calcurse/keys .
ln -s /home/piotr/Dropbox/config/.apts /home/piotr/.calcurse/apts

# feh
cd /home/piotr/.config/feh
ln -s $dot/feh/keys .

# qutebrowser
cd /home/piotr/.config/qutebrowser
ln -s $dot/qtbro/config.py .
ln -s /home/piotr/Dropbox/config/qutebrowser/quickmarks .
touch ./bookmarks/urls

