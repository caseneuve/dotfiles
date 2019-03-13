#!/bin/bash

# Path:        ~/.dotfiles/ranger/send-to-emacs.sh
# Created:     2019-03-13, 11:48    @toshiba
# Last update: 2019-03-13, 11:50:25 @toshiba
# Doc:         send file to gui emacs

emacsclient -n -a emacs "$1"
