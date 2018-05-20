#!/bin/bash

# Path:        ~/.dotfiles/bin/nmt-i3launcher.sh
# Created:     20.05.18, 10:25    @lenovo
# Last update: 20.05.18, 10:33:05 @lenovo

# Doc: Open neomutt @ws 10, if already running, just go there

[[ $(pidof neomutt) ]] && i3-msg -q 'workspace 10' || i3-msg -q 'workspace 10; exec --no-startup-id st -e neomutt'

