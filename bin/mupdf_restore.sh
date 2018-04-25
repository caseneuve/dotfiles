#!/bin/bash

# Path:        ~/.dotfiles/bin/mupdf_restore.sh
# Created:     25.04.18, 21:38    @x200
# Last update: 25.04.18, 21:39:03 @x200

# Doc:

sed '/^$/d; /#/d' $1 | while read line ;
do
    [[ -f $line ]] && mupdf "$line" > /dev/null 2>&1 &
done

