#!/bin/bash

# Path:        ~/.dotfiles/dmenu/dmenu-open-pdf.sh
# Created:     2019-03-05, 13:23    @x200
# Last update: 2019-03-05, 18:48:08 @x200
# Doc:

pdf=$(fd -e pdf . ~ | dmenu -p "Choose pdf file" -l 10)

[[ -f "$pdf" ]] && zathura "$pdf"

