#!/bin/bash

# Path:        ~/.dotfiles/bin/i3quick-floating.sh
# Created:     25.08.18, 16:57    @toshiba
# Last update: 25.08.18, 16:57:52 @toshiba

# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 

# >> RUN: 
i3-msg -q '[instance="myquickterm"] scratchpad show'
~/bin/i3move -s -m 1

