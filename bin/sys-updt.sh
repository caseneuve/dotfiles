#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     2018-05-30, 16:02    @x200
# Last update: 2019-06-12, 13:51:39 @toshiba
# Doc:         Primitive pamac-tray replacement
#              requires pacman-contrib package (`checkupdates` command)

FILE=/tmp/sysupdt
#checkupdates > $FILE &
[ -f $FILE ] && NUM=$(cat $FILE | wc -l) || NUM=0

#GLYPH=' '
#FGCOLOR=$(awk '/^*i3urgent/ {print $2}' $HOME/.Xresources)
#COLOR='#C0392B' # COLOR='#ff5252'

if [ -n $NUM ]; then
    if (( $NUM > 0 )); then
        if [ $(pgrep polybar) ]; then
            echo "$NUM"
        # elif [[ $(pgrep i3blocks) ]]; then
        #     [[ $(grep -o linux-lts $FILE) ]] &&\
        #         echo -e " <span color='$COLOR' weight='bold'>$GLYPH$NUM</span> " ||\
        #             echo -e " $GLYPH$NUM "
        fi
    else
        echo
    fi
fi


# case $BLOCK_BUTTON in
#     1) pkill -RTMIN+12 i3blocks && exit 0 ;;
# esac

