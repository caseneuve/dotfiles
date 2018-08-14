#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-emacs-launcher.sh
# Created:     27.05.18, 09:16    @x200
# Last update: 15.08.18, 00:28:20 @x200

# >> DOC:
# "If emacs is running goes to the first workspace with qtb window; if not -- launches qtb at wksp 1"
# note: requires `wmctrl` package (pacman)

# >> TODOS:
# todo: dodać opcje dla większej liczby otwartych okien (niech cyklicznie przechodzi po następnych)
# todo: przepisać to na py (i3ipc)

# >> VARIABLES:
EMACS_GUI=$(wmctrl -lx | grep "emacs.Emacs" | grep -v grep)
[[ $EMACS_GUI ]] && EMACS_GUI_WS=$(echo $EMACS_GUI | awk '{print $2}')
FOCUSED_WS=$(wmctrl -d | grep "*" | awk '{print $1}')
EMACS_CLI=$(wmctrl -lx | grep "emacsclient" | grep -v grep)

# >> RETURN:
if [[ $EMACS_GUI ]]; then
    if [[ $FOCUSED_WS == $EMACS_GUI_WS ]]; then
        [[ $EMACS_CLI ]] && wmctrl -a emacsclient || notify-send -u low "i3" "<i>No other instances of Emacs visible</i>"
    else
        wmctrl -a Emacs
    fi
else
    echo 'i3-msg "workspace 1; exec --no-startup-id emacs"'
fi

# >> SPADY:
# ws=$(i3-msg -t get_tree | grep -oE "num\":[0-9]*||emacs" | tr "\n" " " | grep -o "num\":[0-9]* emacs" | grep -o [0-9]* | head -n 1)
# [[ "$ws" ]] && i3-msg "workspace $ws" || i3-msg "workspace 1; exec --no-startup-id emacs"

