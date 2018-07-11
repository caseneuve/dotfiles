#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/i3win-title.sh
# Created:     10.07.18, 21:21    @x200
# Last update: 11.07.18, 04:10:25 @lenovo

# Doc:

NAME=`xdotool getactivewindow getwindowname`
LEN=`echo ${#NAME}`
MAX=40

NAME_SHORT=`echo $NAME | sed 's/ - qutebrowser$\|mpv$\|([0-9]* dpi)//g'`

if (( $LEN > 0 )); then
    if (( $LEN > $MAX )); then
        let a=$LEN-$MAX
        echo "<span bgcolor='#00001f26'> ${NAME_SHORT::-$a}… </span>"
    else
        echo "<span bgcolor='#00001f26'> $NAME </span>"
    fi
else
    echo "(¬‿¬)"
fi

case $BLOCK_BUTTON in
    # left click 
    1) notify-send "Focused window title:
---------------------" "<i>$NAME</i>\ncopied to clipboard" && i3-msg "exec --no-startup-id echo '$NAME' | xclip -selection c && exit 1";;
esac

