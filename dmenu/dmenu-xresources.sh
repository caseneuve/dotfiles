#!/bin/bash

# Path:        /home/piotr/.dotfiles/dmenu/dmenu-xresources.sh
# Created:     2019-03-04, 20:28    @x200
# Last update: 2019-03-04, 23:09:23 @x200
# Doc:         copy selected variable's value to clipboard
# Depend.:     rg, xclip, dmenu 

XFILE=$HOME/.Xresources
ARGS="-nb #0a0c10 -nf #ececec -sb #ffb142 -sf #191f26"

xvariable=$(awk '!/!|^$/ && /#/ { gsub("*|:", "", $1); print $1}' $XFILE | dmenu -p "choose variable" $ARGS -fn 'Iosevka Light:size=10')

xvalue=$(rg "^\*$xvariable" $XFILE | awk '{print $2}')

echo $xvalue | xclip -selection clipboard

[[ $xvalue == *"#ff"* || $xvalue == *"#e"* ]] && fgcol=#000000 || fgcol=#ffffff

notify-send -h string:bgcolor:$xvalue -h string:fgcolor:$fgcol "dmenu" "Xresources variable $xvariable: $xvalue copied to clipboard"
