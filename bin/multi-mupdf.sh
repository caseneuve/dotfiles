#!/bin/bash

# Path:        ~/scr/multi-mupdf.sh
# Created:     05.11.18, 22:44    @lenovo
# Last update: 05.11.18, 22:46:44 @lenovo

# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 

# >> RUN:
if [[ -n $@ ]]; then
    for file in $@; do
        mupdf $file &
    done
fi
