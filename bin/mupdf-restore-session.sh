#!/bin/bash

# Path:        ~/.bin/mupdf-restore-session.sh
# Created:     25.04.18, 21:04    @x200
# Last update: 25.04.18, 22:41:23 @manjaroi3

# Doc:

cd ~/.cache
if [[ -f .mupdf_cache ]]; then
    sed '/^$/d; /#/d' .mupdf_cache | while read line ;
    do
        if [[ -f $line ]]; then
            mupdf "$line" > /dev/null 2>&1 &
        else
            echo -e "Plik '$line' nie istnieje!"
            echo -e "$(date +%Y-%m-%d,%H:%M) - $HOSTNAME\nPlik '$line' nie istnieje!"  >> ~/Dropbox/config/mupdf/mupdf-restore.log  
        fi
    done
else
    echo "Nie ma zachowanych sesji mupdf."
fi

