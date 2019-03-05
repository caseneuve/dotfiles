#!/bin/bash

# Path:        /home/piotr/.dotfiles/dmenu/dmenu-xresources.sh
# Created:     2019-03-04, 20:28    @x200
# Last update: 2019-03-05, 12:41:28 @x200
# Doc:         copy selected variable's value to clipboard
# Depend.:     rg, xclip, dmenu 

XFILE=$HOME/.Xresources

xvariable=$(awk '!/!|^$/ && /#/ { gsub("*|:", "", $1); print $1}' \
                $XFILE |\
                dmenu -p "Choose variable")

xvalue=$(rg "^\*$xvariable" $XFILE | awk '{print $2}')

echo $xvalue | xclip -selection clipboard

[[ $xvalue == *"#ff"* || $xvalue == *"#e"* ]] \
    && fgcol=#000000 \
        || fgcol=#ffffff

notify-send -h string:bgcolor:$xvalue -h string:fgcolor:$fgcol \
            "dmenu" \
            "Xresources variable $xvariable: $xvalue copied to clipboard"
