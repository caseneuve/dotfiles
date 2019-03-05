#!/bin/bash

# Path:        ~/.dotfiles/dmenu/dmenu-choose-script.sh
# Created:     2019-03-04, 21:13    @x200
# Last update: 2019-03-05, 12:30:56 @x200
# Doc:         show scripts to execute in dmenu

SCRIPT_DIR=$HOME/.config/dmenu/scripts
ARGS="-i"

script=$(ls $SCRIPT_DIR | dmenu -p "Execute" $ARGS)

$SCRIPT_DIR/$script

