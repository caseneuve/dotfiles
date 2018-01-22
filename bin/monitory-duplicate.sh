# ~/.dotfiles/bin/monitory-duplicate.sh
# Created:     22.01.18, 17:58    @x200
# Last update: 22.01.18, 18:21:15 @x200

# Doc: Checks if there is external output and duplicates screen

#!/bin/bash

intern=LVDS1
extern=VGA1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --auto --output "$extern" --primary --same-as "$intern"
fi

# odśwież wallpaper
feh --bg-fill ~/.i3/wall.jpg

