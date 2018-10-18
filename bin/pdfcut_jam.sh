#!/bin/bash

# Path:        ~/.dotfiles/bin/pdfcut_jam.sh
# Created:     18.10.18, 23:40    @lenovo
# Last update: 19.10.18, 00:58:29 @lenovo
# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 

# >> RUN: 
if pacman -Qs pdfjam > /dev/null ; then
    [[ "${3:$#}" = *".pdf" ]] && out="${3}" || out="${3}.pdf"
    pdfjam "$1" "${2}" -o "$out"
else
    echo "pdfjam not installed"
fi
