#!/bin/bash

# Path:        ~/.dotfiles/bin/mupdf_restore.sh
# Created:     25.04.18, 21:38    @x200
# Last update: 25.04.18, 22:33:22 @manjaroi3

# Doc:

clear

sed '/^$/d; /#/d' $1 | while read line ;
do
    if [[ -f $line ]]; then
        mupdf "$line" > /dev/null 2>&1 &
    else
        echo -e "Plik '$line' nie istnieje!"
    fi
done

