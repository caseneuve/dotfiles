#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     2018-05-30, 16:02    @x200
# Last update: 2019-05-14, 16:02:55 @lenovo
# Doc:         Primitive pamac-tray replacement
#              requires pacman-contrib package (`checkupdates` command)

FILE=/tmp/sysupdt
checkupdates > $FILE

NUM=$(cat $FILE | wc -l )
GLYPH=' '
FGCOLOR=$(awk '/^*urgent/ {print $2}' $HOME/.Xresources)
#COLOR='#C0392B' # COLOR='#ff5252'

if [[ -n $NUM ]]; then
    if (( $NUM > 0 )); then
        if [[ $(pgrep i3blocks) ]]; then
            [[ $(grep -o linux-lts $FILE) ]] &&\
                echo -e " <span color='$COLOR' weight='bold'>$GLYPH$NUM</span> " ||\
                    echo -e " $GLYPH$NUM "
        elif [[ $(pgrep polybar) ]]; then
            echo "$NUM"
        fi
    fi
fi


case $BLOCK_BUTTON in
    1) pkill -RTMIN+12 i3blocks && exit 0 ;;
esac

