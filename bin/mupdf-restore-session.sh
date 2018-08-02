#!/bin/bash

# Path:        ~/.bin/mupdf-restore-session.sh
# Created:     25.04.18, 21:04    @x200
# Last update: 02.08.18, 17:08:51 @x200

# Doc: 
# TODO: przepisać to w pythonie wykorzystując paczkę i3ipc(?), tak żeby zapisywały się numery stron w pliku cache: np {(plik: str), (plik2: str)}

#TEMPFILE='/tmp/mupdf_cache'
CACHEDIR='/home/piotr/.cache/mupdf-cache'
LOGDIR='/home/piotr/.cache/mupdf-log'
[[ -d $LOGDIR ]] || mkdir $LOGDIR
LOGFILE=$LOGDIR/mupdf-restore.log
MYTHEME=~/.config/rofi/mytheme.rasi
[[ -f $MYTHEME ]] || MYTHEME="Pop-Dark"

#selected=$( find $CACHEDIR -type f | dmenu)
selected=$( ls $CACHEDIR | sed 's/cached_//g' | rofi -dmenu -theme $MYTHEME -p 'choose a mupdf session: ')

if [[ $selected ]]; then
    sed '/^$/d; /#/d' $CACHEDIR/cached_$selected | while read line;
    do
        line=$(echo $line | sed 's/-- \| [0-9]*$//g')
        if [[ -f $line ]]; then
            mupdf "$line" > /dev/null 2>&1 &
        else
            echo -e "Plik '$line' nie istnieje!"
            echo -e "$(date +%Y-%m-%d,%H:%M)\nPlik '$line' nie istnieje!"  >> $LOGFILE  
        fi
    done
else
    echo "Nie wybrano żadnej sesji mupdf."
fi

