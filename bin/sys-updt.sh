#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 13.10.18, 21:15:14 @lenovo

# >> DOC: Primitive pamac-tray replacement

# >> TODOs
# note: uses pacman-contrib package! (`checkupdates` command)
# done: ?? po kliknięciu (lewy lub prawy) i3blocks się zwiesza
# done: dodać liczenie ile updatów do ikonki

# >> VARIABLES
FILE=/tmp/sysupdt
checkupdates > $FILE

DIR=~/.dotfiles/i3/bin
CHECK=$(cat $FILE)
NUM=$(cat $FILE | wc -l)
GLYPH=''
COLOR='#C0392B'

# >> i3blocks OUTPUT
if (( $NUM > 0 )); then
    # <span bgcolor='#00001f26'>
    [[ $(cat $FILE | grep -o linux-lts) ]] && echo -e "<span color='$COLOR'><span weight='bold'>$GLYPH $NUM</span></span>" || echo -e "$GLYPH $NUM"
fi

# >> MOUSE BEHAVIOUR
case $BLOCK_BUTTON in
    # left click 
    1) notify-send -u critical "System update:
--------------" "$CHECK" 
       pkill -RTMIN+12 i3blocks && exit 0
       ;;
    # right click
    3) rm $FILE
       st -t sysupdt -e sudo pacman --noconfirm -Syyu
       i3move -p 35 -g 10 -m ne
       pkill -RTMIN+12 i3blocks
       exit 0
       ;;
esac

