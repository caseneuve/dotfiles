#!/bin/bash

# Path:        ~/.dotfiles/bin/nmt-i3launcher.sh
# Created:     20.05.18, 10:25    @lenovo
# Last update: 05.07.18, 13:26:13 @toshiba

# Doc: Open neomutt @ws 10, if already running, just go there

[[ $(pidof neomutt) ]] && i3-msg -q 'workspace 10' || i3-msg -q 'workspace 10; exec --no-startup-id st -e neomutt'
pkill -RTMIN+10 i3blocks
