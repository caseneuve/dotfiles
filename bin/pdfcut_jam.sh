#!/bin/bash

# Path:        ~/.dotfiles/bin/pdfcut_jam.sh
# Created:     18.10.18, 23:40    @lenovo
# Last update: 28.11.18, 12:54:13 @lenovo
# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 

# >> RUN: 
if pacman -Qs pdfjam > /dev/null ; then
    [[ "${3:$#}" = *".pdf" ]] && out="${3}" || out="${3}.pdf"
    [[ -n $4 ]] && opt=--landscape || opt=
    pdfjam "$1" "${2}" -o "$out" $opt
else
    echo "pdfjam not installed"
fi
