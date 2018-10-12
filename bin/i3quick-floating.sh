#!/bin/bash

# Path:        ~/.dotfiles/bin/i3quick-floating.sh
# Created:     25.08.18, 16:57    @toshiba
# Last update: 13.10.18, 01:42:07 @lenovo

# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 

# >> RUN:

if [[ $(ps aux | grep myquickterm | grep -v grep) ]]; then
    i3-msg -q '[instance="myquickterm"] scratchpad show' && ~/bin/i3move -s -m 1
else
    i3-msg -q "exec --no-startup-id st -c 'scratch' -n myquickterm -f 'Inconsolata:size=13'" && sleep 0.05
    i3-msg -q '[instance="myquickterm"] scratchpad show' && ~/bin/i3move -s -m 1
fi
