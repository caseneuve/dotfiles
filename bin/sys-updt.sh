#!/bin/bash

# Path:        ~/.dotfiles/bin/sys-updt.sh
# Created:     30.05.18, 16:02    @x200
# Last update: 25.08.18, 21:21:54 @toshiba

# >> DOC: Primitive pamac-tray replacement

# >> TODOs
# note: uses pacman-contrib package! (`checkupdates` command)
# check: spr. czy $DISTRO działa na wszystkich maszynach 
# note: zmieniam DISTRO na antergos (skoro wszędzie to samo)
# done: ?? po kliknięciu (lewy lub prawy) i3blocks się zwiesza
# done: dodać liczenie ile updatów do ikonki

# >> VARIABLES
FILE=/tmp/sysupdt
checkupdates > $FILE

DIR=~/.dotfiles/i3/bin
CHECK=$(cat $FILE)
NUM=$(cat $FILE | wc -l)
DISTRO=antergos
GLYPH=''
COLOR='#C0392B'

# >> i3blocks OUTPUT
if (( $NUM > 0 )); then
    # <span bgcolor='#00001f26'>
    [[ $(cat $FILE | grep -o linux-lts) ]] && echo -e "<span color='$COLOR'><span weight='bold'>$GLYPH $NUM</span></span>" || echo -e "$GLYPH $NUM"
fi

# >> MOUSE BEHAVIOUR
case $BLOCK_BUTTON in
    # left click 
    1) notify-send -u critical "System update:
--------------" "$CHECK" -i $DIR/$DISTRO-logo.png
       pkill -RTMIN+12 i3blocks && exit 0
       ;;
    # right click
    3) st -t sysupdt -e sudo pacman --noconfirm -Syyu
       pkill -RTMIN+12 i3blocks
       exit 0
       ;;
esac

# >> SPADY
#redbg=`tput setab 1`
#nor=`tput sgr0`
# DISTRO=`cat /etc/*-release | grep ^ID= | sed 's/^ID=\"\|\"\|ID=//g'`
# DISTRO=`cat /etc/issue | awk '{print tolower($1)}' | head -n 1`

# while getopts 'nry' flag; do
#     case "${flag}" in
#         n) [[ -z "$CHECK" ]] && notify-send -u low "System update:
# --------------" "System is up to date :-)" -i $DIR/$DISTRO-logo.png || notify-send -u critical "System update:
# --------------" "$CHECK" -i $DIR/$DISTRO-logo.png && exit 0;;
#         r) i3-msg -q "exec --no-startup-id st -t sysupdt -e sudo pacman --noconfirm -Syyu"
#            pkill -RTMIN+12 i3blocks && exit 0;;
#         y) i3-msg -q "exec --no-startup-id st -t sysupdt -e yaourt --noconfirm -Syu --aur" && exit 0;;
#         # h) print_help;;
#         *) main;;
#     esac
# done
           
# print_help(){
# printf "sys-updt = system update script
#  -n              outpusend notification"
# }

