#!/bin/bash

# Path:        ~/.dotfiles/bin/auto-config/auto-config.sh
# Created:     16.06.18, 23:27    @lenovo
# Last update: 16.06.18, 23:29:03 @lenovo

# Doc: sudo this script to config system

./01_bash-config.sh &&\
    ./02_clone-repos.sh &&\
    ./03_mypackages.sh &&\
    ./04_config-after-clone.sh

