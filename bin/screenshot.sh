#!/bin/bash

# Path:        ~/.dotfiles/bin/screenshot.sh
# Created:     2019-03-27, 10:48    @toshiba
# Last update: 2019-06-11, 21:40:20 @toshiba
# Doc:         Take a screenshot with maim, show it and ask how to save it.
# Requires:    [maim, sxiv, dmenu, xdotool, mypaint, notify-send]
# Todo:        27/03/2019 install i3move in the system? path? (?)
# Todo:        27/03/2019 add x and y gaps to i3move

#* variables
ARG=${1:-}
EDIT=false
MOVE=$HOME/git/hub/i3/i3move.py
SOUND="/usr/share/sounds/freedesktop/stereo/screen-capture.oga"
MENU="rofi -theme i3on-window -monitor -2 -dmenu -p"  # was: dmenu -p


#* setup
setup(){
    DIR=$HOME/obr/maim
    FILE=/tmp/$(date +%Y%b%d_%H.%M.%S).maim.png

    case $ARG in
        -i|i|'active') ARG="-u -i $(xdotool getactivewindow)" ;;
        -s|s|'select') ARG="-u -s"
                       notify-send \
                           -t 3000 \
                           -u low \
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

#* show and move
show_and_move() {
    sxiv -b -s f $FILE &
    sleep .3
    i3-msg -q border pixel 2
    #$MOVE -p 33 # -g 30 -m nw
    $MOVE -p 65 -m c
    #i3-msg -q move left 20
    #i3-msg -q move center
}

#* ask
ask() {
    $EDIT || save=$(echo -e "yes\nno" | $MENU "save this shot?")
    if $EDIT || [ $save == yes ]; then
        rename=$(echo -e "no" | $MENU "rename shot?")
        case $rename in
            no) SAVED=$DIR/$(basename $FILE) ;;
            *) SAVED=$DIR/${rename}.png
                cp $FILE $SAVED;;
        esac
        cp $FILE $SAVED
    else
        cleanup
        exit 1
    fi
}


#* cleanup
cleanup() {
    rm $FILE
    ps aux | rg sxiv | rg $FILE | awk '{print $2}' | xargs kill -9
}


#* edit
edit() {
    while true; do
        if $EDIT; then
            mypaint $SAVED &
            i3-msg -q "workspace number 6"
            break
        else
            edit=$(echo -e "no\nyes" | $MENU "edit shot?")
            [[ $edit == yes ]] && EDIT=true || break
        fi
    done
}


#* main
main() {
    setup
    if $SHOT; then
        paplay --volume 60000 $SOUND
        show_and_move
        ask
        edit
        cleanup
    else
        exit 1
    fi
}

main
