#!/bin/bash

# Path:        ~/.dotfiles/polybar/polybar-toggle.sh
# Created:     2019-05-29, 21:47    @x200
# Last update: 2019-05-29, 21:52:59 @x200

echo cmd:toggle >> /tmp/polybar-ipc-primary
[[ $(ps aux | grep "polybar.*secondary" | grep -v grep) ]] &&\
    echo cmd:toggle >> /tmp/polybar-ipc-secondary
