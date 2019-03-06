#!/bin/bash

# Path:        ~/.dotfiles/dmenu/dmenu-open-in-emacs.sh
# Created:     2019-03-05, 19:30    @toshiba
# Last update: 2019-03-05, 20:57:13 @toshiba
# Doc:         choose a file in dmenu and send it to emacs

DIRS="$HOME/web/schole $HOME/box $HOME/.config $HOME/.dotfiles $HOME/git $HOME/biu $HOME/scr"

file=$(fd -t f -H -d 6 \
          -E '__init__*' -E "*.pdf" -E '*.mp?' -E '*.csv' \
          -E '*.xls*' -E '*.doc?' -E '*.odt' -E '*.jpg' \
          -E '*.png' -E '*.cache*' -E '__pycache__' \
          . $DIRS \
           | sed 's|'"$HOME"'||' \
           | sort \
           | dmenu -p "Choose & Emacs" -l 10)

file="$HOME$file"

[[ -f "$file" ]] && emacsclient -n -a emacs "$file"
