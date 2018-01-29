#!/bin/bash

# ~/.dotfiles/bin/monitory.sh
# Created:     ?
# Last update: 26.01.18, 13:38:45 @x200

# Doc: Sprawdza czy są podłączone inne monitory i ustawia zewnętrzny po lewej

intern=LVDS1
extern=VGA1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --auto --output "$extern" --auto --left-of "$intern"
fi

feh --bg-fill ~/.i3/wall.jpg

# if [ "$(xrandr --screen 0 | grep -i 'vga1 connected')" ]
# then
#     xrandr --output eDP1 --auto --output VGA1 --auto --left-of eDP1
# else
#     xrandr --output eDP1 --auto --output VGA1 --off
# fi 

