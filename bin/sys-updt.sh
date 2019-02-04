#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 04.02.19, 15:47:20 @lenovo

# >> DOC:
# Primitive pamac-tray replacement

# >> TODOs
# note: uses pacman-contrib package! (`checkupdates` command)

# >> VARIABLES
FILE=/tmp/sysupdt
checkupdates > $FILE

CHECK=$(cat $FILE)
NUM=$(cat $FILE | wc -l)
GLYPH=' '
COLOR='#C0392B'

# >> i3blocks OUTPUT
if [[ -n $NUM ]]; then
    if (( $NUM > 0 )); then
        # <span bgcolor='#00001f26'>
        [[ $(cat $FILE | grep -o linux-lts) ]] &&\
            echo -e "<span color='$COLOR' weight='bold'>$GLYPH$NUM</span>" ||\
                echo -e "$GLYPH$NUM"
    fi
fi

# >> MOUSE BEHAVIOUR [off]
# case $BLOCK_BUTTON in
#     # left click 
#     1) notify-send -u critical "System update:
# --------------" "$CHECK" 
#        pkill -RTMIN+12 i3blocks && exit 0
#        ;;
#     # right click
#     3) rm $FILE
#        #st -t sysupdt -e sudo pacman --noconfirm -Syyu
#        st -c sysupdt -e yay --noconfirm -Syu &\
#            [[ $(~/git/hub/i3/i3get.sh -c) == sysupdt ]] &&\
#                ~/bin/i3move -p 35 -g 10 -m ne && pkill -RTMIN+12 i3blocks
#        exit 0
#        ;;
# esac

