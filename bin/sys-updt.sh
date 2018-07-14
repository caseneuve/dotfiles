#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 13.07.18, 22:16:43 @x200

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
# DISTRO=`cat /etc/*-release | grep ^ID= | sed 's/^ID=\"\|\"\|ID=//g'`
# DISTRO=`cat /etc/issue | awk '{print tolower($1)}' | head -n 1`

checkupdates > /tmp/sysupdt

while getopts 'nry' flag; do
    case "${flag}" in
        n) [[ -z "$check" ]] && notify-send -u low "System update:
--------------" "System is up to date :-)" -i $dir/$DISTRO-logo.png || notify-send -u critical "System update:
--------------" "$check" -i $dir/$DISTRO-logo.png && exit 0;;
        r) i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman --noconfirm -Syyu"
           pkill -RTMIN+12 i3blocks && exit 0;;
        y) i3-msg -q "exec --no-startup-id st -t sysupdt -e yaourt --noconfirm -Syu --aur" && exit 0;;
        # h) print_help;;
        *) main;;
    esac
done
           
# print_help(){
# printf "sys-updt = system update script
#  -n              outpusend notification"
# }
           
main(){
    if (( $num > 0 )); then
        [[ `cat $file | grep -o linux-lts` ]] && echo -e "<span bgcolor='#e74c3c'><span fgcolor='#ececec'> 𝕌$num </span></span>" || echo -e "<span bgcolor='#ececec'> 𝕌$num </span>"
fi
}

case $BLOCK_BUTTON in
    # left click 
    1) notify-send -u critical "System update:
--------------" "$check" -i $dir/$DISTRO-logo.png && exit 0;;
    # right click
    3) i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman --noconfirm -Syyu"
       pkill -RTMIN+12 i3blocks && exit 0;;
esac

