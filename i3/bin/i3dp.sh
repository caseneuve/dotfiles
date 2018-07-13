#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/i3dp.sh
# Created:     10.07.18, 18:45    @x200
# Last update: 13.07.18, 11:38:29 @lenovo

# Doc: note: requires dropbox-cli (AUR)

if [[ `dropbox-cli status | grep "isn't"` ]]; then
    echo "<span bgcolor='#2980b9'><span color='#ffffff'>𝔻!</span></span>"
elif [[ `dropbox-cli status | grep -i "synchronizowanie"` ]]; then
    echo "<span bgcolor='#00fa9a'><span color='#000000'>𝔻↓↑</span></span>"
else
    pkill -RTMIN+13 i3blocks
fi

