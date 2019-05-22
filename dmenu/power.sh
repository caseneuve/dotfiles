#!/bin/bash

# Path:        ~/.dotfiles/dmenu/power.sh
# Created:     2019-05-22, 17:39    @x200
# Last update: 2019-05-22, 17:45:37 @x200

opt=$(echo -e "[1] poweroff\n[2] reboot\n[3] suspend" | dmenu -p "Power command:")

case $opt in
    *poweroff*) systemctl poweroff -i ;;
    *reboot*) systemctl reboot -i ;;
    *suspend*) ~/.dotfiles/i3/i3lock/i3betterlock.sh &
               systemctl suspend -i;;
esac
