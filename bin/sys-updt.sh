#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 26.06.18, 14:09:20 @lenovo

# Doc: Primitive pamac-tray replacement
# NOTE: uses pacman-contrib package!
# bug: ? spr. czy $DISTRO działa na wszystkich maszynach 
# note: zmieniam DISTRO na antergos (skoro wszędzie to samo)

dir=~/.dotfiles/i3/bin
check=`checkupdates`
redbg=`tput setab 1`
nor=`tput sgr0`
#DISTRO=`cat /etc/*-release | grep ^ID= | sed 's/^ID=\"\|\"\|ID=//g'`
#DISTRO=`cat /etc/issue | awk '{print tolower($1)}' | head -n 1`
DISTRO=antergos

if ! [ -z "$check" ]; then
#    echo -e "<span bgcolor=\"#e74c3c\"> ♻ </span>"
    echo -e "<span bgcolor=\"#ececec\">♻</span>"
fi

case $BLOCK_BUTTON in
    # left click = previous song
    1) if ! [ -z "$check" ]; then
           notify-send "System update:
--------------" "$check" -i $dir/$DISTRO-logo.png && exit 0;
       else
           notify-send "No updates" -i $dir/$DISTRO-logo.png && exit 0;
       fi ;;
    # right click
    3) if ! [ -z "$check" ]; then
           i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman --noconfirm -Syyu" && exit 0 
       else
           exit 0
       fi;;
esac
exit 0
