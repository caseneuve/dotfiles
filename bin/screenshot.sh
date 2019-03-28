#!/bin/bash

# Path:        ~/.dotfiles/bin/screenshot.sh
# Created:     2019-03-27, 10:48    @toshiba
# Last update: 2019-03-28, 07:06:55 @x200
# Doc:         Take a screenshot with maim, show it and ask how to save it.
# Requires:    [maim, sxiv, dmenu, xdotool, mypaint]
# Todo:        27/03/2019 install i3move in the system? path? (?)
# Todo:        27/03/2019 add x and y gaps to i3move

ARG=${1:-}
EDIT=false

setup(){
    DIR=$HOME/obr/maim
    FILE=/tmp/$(date +%Y%b%d_%H.%M.%S).maim.png

    case $ARG in
        -i|i|'active') ARG="-u -i $(xdotool getactivewindow)" ;;
        -s|s|'select') ARG="-u -s"
                       notify-send \
                           -t 3000 \
                           "select region to shot:" \
                           "\
1) left click -- active window
2) click and drag -- mark region
3) else -- cancel
" ;;
        -e|e|'edit')   ARG="-u"; EDIT=true ;;
        *)             ARG="-u" ;;
    esac

    SHOT="maim $ARG $FILE"
}

show_and_move() {
    sxiv -b -s f $FILE &
    sleep .1
    $HOME/git/hub/i3/i3move.py -p 33 -g 30 -m nw
    i3-msg -q move left 20
}

ask() {
    $EDIT || save=$(echo -e "yes\nno" | dmenu -p "save shot?")
    if $EDIT || [ $save == yes ]; then
        rename=$(echo -e "no" | dmenu -p "rename shot?")
        case $rename in
            no) SAVED=$DIR/$(basename $FILE) ;;
            *) SAVED=$DIR/${rename}.png
                cp $FILE $SAVED;;
        esac
        cp $FILE $SAVED
        cleanup
    else
        cleanup
        exit 1
    fi
}

cleanup() {
    rm $FILE
    ps aux | rg sxiv | rg $FILE | awk '{print $2}' | xargs kill -9
}

edit() {
    while true; do
        if $EDIT; then
            mypaint $SAVED &
            i3-msg -q "workspace number 6"
            exit
        else
            edit=$(echo -e "no\nyes" | dmenu -p "edit shot?")
            [[ $edit == yes ]] && EDIT=true || exit
        fi
    done
}

main() {
    setup
    if $SHOT; then
        show_and_move
        ask
        edit
    else
        exit 1
    fi
}

main
