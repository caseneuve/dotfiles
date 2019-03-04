#!/bin/bash

# Path:        ~/.dotfiles/dmenu/dmenu-choose-script.sh
# Created:     2019-03-04, 21:13    @x200
# Last update: 2019-03-04, 22:55:25 @x200
# Doc:

SCRIPT_DIR=$HOME/.config/dmenu/scripts

script=$(ls $SCRIPT_DIR | dmenu -p "Execute" -nb "#0a0c10" -nf "#ececec" -sb "#ffb142" -sf "#191f26" -fn "Iosevka Light:size=10")

$SCRIPT_DIR/$script

