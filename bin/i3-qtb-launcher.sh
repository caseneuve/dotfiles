#!/bin/bash

# Path:        ~/.dotfiles/bin/qtb-launcher.sh
# Created:     26.05.18, 23:42    @x200
# Last update: 13.08.18, 15:53:38 @x200

# Doc: If qutebrowser is running goes to the first workspace with qtb window; if not -- launches qtb at wksp 2
# TODO: przepisać to na py (i3ipc)
ws=$(i3-msg -t get_tree | grep -oE "num\":[0-9]*||qutebrowser" | tr "\n" " " | grep -o "num\":[0-9]* qutebrowser" | grep -o [0-9]* | head -n 1)

[[ "$ws" ]] && i3-msg "workspace $ws" || i3-msg "workspace 2; exec --no-startup-id qutebrowser"

