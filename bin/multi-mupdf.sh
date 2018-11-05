#!/bin/bash

# Path:        ~/scr/multi-mupdf.sh
# Created:     05.11.18, 22:44    @lenovo
# Last update: 05.11.18, 23:26:23 @lenovo

# >> DOC: 
# Open multiple marked pdf files.

# >> TODOS: 

# >> VARIABLES: 
mu_files="pdf jpg png epub"
combo=

# >> RUN:
if [[ -n $@ ]]; then
    for file in $@; do
        ext="${file##*.}"
        if echo $mu_files | grep -w $ext  > /dev/null ; then
            if [[ -f "$combo$file" ]]; then
                mupdf "$combo$file" &
                combo=
            fi
        else
            if [[ ! -f "$file" ]]; then
                combo="$combo$file "
            fi
        fi
    done
fi

