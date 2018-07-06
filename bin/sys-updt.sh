#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 06.07.18, 21:39:30 @toshiba

# DOC: Primitive pamac-tray replacement
# note: uses pacman-contrib package!
# note: ? spr. czy $DISTRO działa na wszystkich maszynach 
# note: zmieniam DISTRO na antergos (skoro wszędzie to samo)
# BUG: ?? po kliknięciu (lewy lub prawy) i3blocks się zwiesza
# TODO: dodać liczenie ile updatów do ikonki

dir=~/.dotfiles/i3/bin
check=`checkupdates`
redbg=`tput setab 1`
nor=`tput sgr0`
DISTRO=antergos
#DISTRO=`cat /etc/*-release | grep ^ID= | sed 's/^ID=\"\|\"\|ID=//g'`
#DISTRO=`cat /etc/issue | awk '{print tolower($1)}' | head -n 1`


if ! [ -z "$check" ]; then
#    echo -e "<span bgcolor=\"#e74c3c\"> ♻ </span>"
    echo -e "<span bgcolor=\"#ececec\">♻</span>"
fi

case $BLOCK_BUTTON in
    # left click 
    1) if [ ! -z "$check" ]; then
           notify-send "System update:
--------------" "$check" -i $dir/$DISTRO-logo.png;
       else
           notify-send "No updates" -i $dir/$DISTRO-logo.png;
       fi ;;
    # right click
    3) if [ ! -z "$check" ]; then
           i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman --noconfirm -Syyu && pkill -RTMIN+12 i3blocks"
       fi;;
esac

