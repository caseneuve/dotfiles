#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 10.07.18, 23:14:34 @x200

# DOC: Primitive pamac-tray replacement
# note: uses pacman-contrib package!
# todo: spr. czy $DISTRO działa na wszystkich maszynach 
# note: zmieniam DISTRO na antergos (skoro wszędzie to samo)
# done: ?? po kliknięciu (lewy lub prawy) i3blocks się zwiesza
# done: dodać liczenie ile updatów do ikonki

dir=~/.dotfiles/i3/bin
file=/tmp/sysupdt
check=`cat $file`
num=`cat $file | wc -l`
redbg=`tput setab 1`
nor=`tput sgr0`
DISTRO=antergos
#DISTRO=`cat /etc/*-release | grep ^ID= | sed 's/^ID=\"\|\"\|ID=//g'`
#DISTRO=`cat /etc/issue | awk '{print tolower($1)}' | head -n 1`

checkupdates > /tmp/sysupdt

if (( $num > 0 )); then
    [[ `cat $file | grep -o linux-lts` ]] && echo -e "<span bgcolor='#e74c3c'> 𝕌$num </span>" || echo -e "<span bgcolor='#ececec'> 𝕌$num </span>"
fi

case $BLOCK_BUTTON in
    # left click 
    1) notify-send -u critical "System update:
--------------" "$check" -i $dir/$DISTRO-logo.png;;
    # right click
    3) i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman --noconfirm -Syyu && pkill -RTMIN+12 i3blocks";;
esac

