#!/bin/bash

# Path:        ~/.dotfiles/bin/mupdf_restore.sh
# Created:     25.04.18, 21:38    @x200
# Last update: 02.08.18, 16:49:58 @x200

# Doc: NOTE: DEPRECATED! Don't use it

clear

sed '/^$/d; /#/d' $1 | while read line ;
do
    if [[ -f $line ]]; then
        mupdf "$line" > /dev/null 2>&1 &
    else
        echo -e "Plik '$line' nie istnieje!"
        echo -e "$(date '+%Y-%m-%d, %H:%M') - $HOSTNAME:\nPlik '$line' nie istnieje!"  >> ~/Dropbox/config/mupdf/mupdf-restore.log  
    fi
done

