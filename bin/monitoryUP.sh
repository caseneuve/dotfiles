#!/bin/bash

# Path:        ~/.dotfiles/bin/monitory-UP.sh
# Created:     06.07.18, 09:47    @toshiba
# Last update: 06.07.18, 11:36:55 @toshiba

# Doc:

intern=LVDS1
extern=VGA1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x1050 --rotate normal --output "$extern" --mode 1680x1050 --pos 0x0 --rotate normal
fi

~/.fehbg

