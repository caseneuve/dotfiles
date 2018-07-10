#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 10.07.18, 05:35:10 @x200

# DOC: Primitive pamac-tray replacement
# note: uses pacman-contrib package!
# todo: spr. czy $DISTRO działa na wszystkich maszynach 
# note: zmieniam DISTRO na antergos (skoro wszędzie to samo)
# done: ?? po kliknięciu (lewy lub prawy) i3blocks się zwiesza
# done: dodać liczenie ile updatów do ikonki

dir=~/.dotfiles/i3/bin
#check=`checkupdates`
num=`checkupdates | wc -l`
redbg=`tput setab 1`
nor=`tput sgr0`
DISTRO=antergos
#DISTRO=`cat /etc/*-release | grep ^ID= | sed 's/^ID=\"\|\"\|ID=//g'`
#DISTRO=`cat /etc/issue | awk '{print tolower($1)}' | head -n 1`

if (( $num > 0 )); then
    echo -e "<span bgcolor=\"#ececec\">♻<sup>$num</sup></span>"
fi

case $BLOCK_BUTTON in
    # left click 
    1) notify-send "System update:
--------------" "$check" -i $dir/$DISTRO-logo.png;;
    # right click
    3) i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman --noconfirm -Syyu && pkill -RTMIN+12 i3blocks";;
esac

