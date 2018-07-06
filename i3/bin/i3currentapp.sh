#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/i3currentapp.sh
# Created:     06.07.18, 20:24    @toshiba
# Last update: 06.07.18, 20:36:37 @toshiba

# Doc:

if [ "$(xrandr | grep -o 'VGA1 connected')" ]; then
    id=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
    app=$(xprop -id $id | grep WM_CLASS | awk '{print $4}' | sed 's/"//g' | tr '[:lower:]' '[:upper:]')
    name=$(xprop -id $id | awk '/_NET_WM_NAME/{$1=$2="";print}' | sed 's/"//g') # | cut -d'"' -f2)
    colon=""

    namecolor=#008b8b
    appcolor=#ff4500
    # ff8c00

    if [ "$app" = ""]; then
        namecolor=""
        appcolor=""
    elif [ "$app" = "QUTEBROWSER" ]; then
        app="QTB"
        colon=" "
        name=$(echo $name | sed 's/- qutebrowser//g')
    elif [ "$app" == "MPV" ]; then
        name=$(echo $name | sed 's/- mpv//g')
    elif [ "$app" == "SLACK" ]; then
        name=$(echo $name | sed 's/Slack -//g')
    elif [[ "$app" == "ST-256COLOR" && "$name" == "  dropdown" ]]; then
        app="TMUX";
        colon=" "
        name="$(tmux list-windows | grep "\*" | awk '{print $2}' | sed 's/\*//')"
    elif [[ "$app" = "ST-256COLOR" && ! "$name" = "  dropdown" ]]; then
        app="TERM";
        colon=""
        name=""
    fi
    
    echo "<span bgcolor=\"$appcolor\">$app</span><span bgcolor=\"$namecolor\">$colon$name</span>"
fi

