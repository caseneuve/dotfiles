#!/bin/bash

# Path:        ~/.dotfiles/polybar/filesystem.sh
# Created:     2019-05-14, 17:01    @x200
# Last update: 2019-05-30, 19:46:46 @toshiba
# Doc:

HOME_PART_ROOT="/dev/sda"

case $(hostname) in
    x200) HOME_PART=$HOME_PART_ROOT"4" ;;
    lenovo|toshiba) HOME_PART=$HOME_PART_ROOT"2" ;;
esac

df -h | awk '$0~v { gsub("G",""); print $4}' v=$HOME_PART
