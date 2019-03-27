#!/bin/bash

# Path:        ~/.dotfiles/bin/screenshot.sh
# Created:     2019-03-27, 10:48    @toshiba
# Last update: 2019-03-27, 13:21:50 @toshiba
# Doc:         Take a screenshot with maim, show it and ask how to save it.
# Todo:        27/03/2019 install i3move (?)
# Todo:        27/03/2019 add x and y gaps to i3move

ARG=${1:-}

setup(){
    DIR=$HOME/obr/maim
    FILE=/tmp/$(date +%Y%b%d_%H.%M.%S).maim.png

    case $ARG in
        -i|i|'active') ARG="-u -i $(xdotool getactivewindow)" ;;
        -s|s|'select') ARG="-u -s" ;;
        *)             ARG="-u" ;;
    esac

    SHOT="maim $ARG $FILE"
}

show_and_move() {
    sxiv -b $FILE &
    $HOME/git/hub/i3/i3move.py -p 33 -g 30 -m nw
    i3-msg -q move left 20
}

ask() {
    save=$(echo -e "yes\nno" | dmenu -p "save shot?")
    if [[ $save == yes ]]; then
        rename=$(echo -e "no" | dmenu -p "rename shot?")
        case $rename in
            no) cp $FILE $DIR ;;
            *) cp $FILE $DIR/${rename}.png
        esac
    fi
}

cleanup() {
    rm $FILE
    ps aux | rg sxiv | rg $FILE | awk '{print $2}' | xargs kill -9
}

main() {
    setup
    if $SHOT; then
        show_and_move
        ask
        cleanup
    else
        exit 1
    fi
}

main
