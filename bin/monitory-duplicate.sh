#!/bin/bash

# ~/.dotfiles/bin/monitory-duplicate.sh
# Created:     22.01.18, 17:58    @x200
# Last update: 06.07.18, 12:33:01 @toshiba

# Doc: Checks if there is external output and duplicates screen
# FIXME:
# [ ] znika status bar
# [ ] większy ekran wyświetla tylko to co na małym nie dostosowując rozdzielczości

intern=LVDS1
extern=VGA1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$extern" --primary --output "$intern" --same-as "$extern" 
fi

# odśwież wallpaper
~/.fehbg

