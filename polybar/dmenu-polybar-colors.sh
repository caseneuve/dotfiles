#!/bin/bash

# Path:        ~/.dotfiles/polybar/dmenu-polybar-colors.sh
# Created:     2019-05-19, 13:52    @lenovo
# Last update: 2019-05-19, 13:55:50 @lenovo
# Doc:

if [[ -n $XPOLYBAR_COLORS ]]; then
    opt=$XPOLYBAR_COLORS
else
    colors="solid\nopaque"
    opt=$(echo -e $colors | dmenu -p "choose polybar color scheme: ")
fi

case $opt in
    opaque) cp ~/.xfiles/polybar_opaque ~/.xfiles/x-polybar
            export XPOLYBAR_COLORS=opaque
            ;;
    solid)  cp ~/.xfiles/polybar_solid ~/.xfiles/x-polybar
            export XPOLYBAR_COLORS=solid
            ;;
esac

xrdb -merge ~/.Xresources
polybar-msg cmd restart
