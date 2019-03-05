#!/bin/bash

# Path:        ~/.dotfiles/dmenu/dmenu-cfp.sh
# Created:     2019-03-04, 23:40    @x200
# Last update: 2019-03-05, 12:42:30 @x200
# Doc:         select file and copy it's path to clipboard

ARGS="-i -l 10"
DIRS="$HOME/box $HOME/pdf $HOME/dwl"
dir=$(fd -H -t f -t d . $DIRS |\
          sed 's|/home/piotr/||' | sort |\
          dmenu -p "Choose file" $ARGS)

if [[ -f "$HOME/$dir" ]]
then
    echo "$HOME/$dir" | xclip -selection clipboard
    file=$(basename "$dir")
    notify-send "Dmenu"\
                "<br><i>$file</i><br><br>path copied to clipboard"
fi

