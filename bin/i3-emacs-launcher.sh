#!/bin/bash

# Path:        ~/.dotfiles/bin/i3-emacs-launcher.sh
# Created:     27.05.18, 09:16    @x200
# Last update: 13.08.18, 15:54:38 @x200

# Doc: If emacs is running goes to the first workspace with qtb window; if not -- launches qtb at wksp 1
# todo: przepisać to na py (i3ipc)

ws=$(i3-msg -t get_tree | grep -oE "num\":[0-9]*||emacs" | tr "\n" " " | grep -o "num\":[0-9]* emacs" | grep -o [0-9]* | head -n 1)

[[ "$ws" ]] && i3-msg "workspace $ws" || i3-msg "workspace 1; exec --no-startup-id emacs"

