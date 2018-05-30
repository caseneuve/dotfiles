#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 30.05.18, 17:44:41 @x200

# Doc: Primitive pamac tray replacement
dir=~/.dotfiles/i3/bin
check=`checkupdates`
redbg=`tput setab 1`
nor=`tput sgr0`

if ! [ -z "$check" ]; then
#    echo -e "<span bgcolor=\"#e74c3c\"> ♻ </span>"
    echo " ♻ "
fi

case $BLOCK_BUTTON in
    # left click = previous song
    1) if ! [ -z "$check" ]; then
           notify-send "System update:
--------------" "echo $check" -i $dir/$HOSTNAME-logo.png && exit 0;
       else
           notify-send "No updates" -i $dir/$HOSTNAME-logo.png && exit 0;
       fi ;;
    # right click
    3) if ! [ -z "$check" ]; then
           i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman -Syyu" && exit 0
       else
           exit 0
       fi;;
esac
exit 0
