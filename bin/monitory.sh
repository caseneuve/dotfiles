# ~/.dotfiles/bin/monitory.sh
# Created:     ?
# Last update: 22.01.18, 18:22:20 @x200

# Doc: Sprawdza czy są podłączone inne monitory i ustawia 
#
# Aktualizuje repozytoria 'dotfiles' i 'emacs/load' na lokalnym komputerze

#!/bin/bash

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

