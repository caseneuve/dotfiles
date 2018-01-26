#!/bin/bash

# Path:        ~/.dotfiles/bin/monitoryR.sh
# Created:     26.01.18, 13:37    @x200
# Last update: 26.01.18, 13:38:54 @x200

# Doc: Sprawdza czy są podłączone inne monitory i ustawia zewnętrzny po prawej

intern=LVDS1
extern=VGA1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --auto --output "$extern" --auto --right-of "$intern"
fi

feh --bg-fill ~/.i3/wall.jpg

