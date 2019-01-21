#!/bin/bash

# Path:        ~/.dotfiles/ranger/ranger-shell.sh
# Created:     21.01.19, 12:05    @lenovo
# Last update: 21.01.19, 12:27:24 @lenovo

# >> DOC:
# Check which shell is currently running and run it in CWD.
# Bound to "S" in browser mode.

# >> RUN:
# fix: it seems to be a dirty hack; todo: check on which shell ranger is being run and go there 
if [[ $(ps aux | grep fish) ]]; then
    eval /usr/bin/fish
elif [[ $BASH || $ZSH_NAME ]]; then
    eval $SHELL
fi
