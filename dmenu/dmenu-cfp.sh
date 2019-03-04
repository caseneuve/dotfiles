#!/bin/bash

# Path:        ~/.dotfiles/dmenu/dmenu-cfp.sh
# Created:     2019-03-04, 23:40    @x200
# Last update: 2019-03-05, 00:28:26 @x200
# Doc:         select file and copy it's path to clipboard

ARGS="-i -nb #0a0c10 -nf #ececec -sb #ffb142 -sf #191f26 -l 10"

dir=$(fd -H -t d -d 4 . ~ | sed 's|/home/piotr/||' | sort | dmenu -p "Choose dir" -fn "Iosevka Light:size=10" $ARGS )

if [[ -d "$HOME/$dir" && "$dir" != "" ]]
then
    file=$(fd -H . "$dir" | sed 's@'"$dir"'@@' | sort | dmenu -p "Select in: ~/$dir" -fn "Iosevka Light:size=10" $ARGS)
else
    exit
fi

if [[ -f "$HOME/$dir$file" ]]
then
    echo "$HOME/$dir$file" | xclip -selection clipboard
    file=$(basename "$file")
    notify-send "Dmenu"\
                "<br><i>$file</i><br><br>path copied to clipboard"
fi

