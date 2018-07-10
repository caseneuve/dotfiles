#!/bin/bash

# Path:        ~/.dotfiles/i3/bin/i3dp.sh
# Created:     10.07.18, 18:45    @x200
# Last update: 10.07.18, 23:00:52 @x200

# Doc: note: requires dropbox-cli (AUR)

if [[ `dropbox-cli status | grep "isn't"` ]]; then
    echo "<span bgcolor='#2980b9'>𝔻!</span>"
else
    pkill -RTMIN+13 i3blocks
fi

