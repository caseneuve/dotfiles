#!/bin/bash

# Path:        ~/.bin/mupdf-restore-session.sh
# Created:     25.04.18, 21:04    @x200
# Last update: 25.04.18, 21:13:43 @x200

# Doc:

cd ~/.cache
sed '/^$/d; /#/d' .mupdf_cache | while read line ;
do
    [[ -f $line ]] && mupdf "$line" > /dev/null 2>&1 &
done 

