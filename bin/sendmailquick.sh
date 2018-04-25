#!/bin/bash

clear

read -p "Do kogo chcesz wysłać wiadomość? " mailaddress
#read -p "Temat wiadomości: " subject
#read -p "Treść wiadomości: " body

if [ -z "$1" ]; then
    echo "Nie zaznaczyłeś załączników";
else
    echo "-- Wiadomość wysłana automatycznie $(date '+%d/%m o %H:%M'), zawiera następujące pliki << $@ >> --" | mutt -s "ranger" $mailaddress -a "$@" > /dev/null 2>&1 
fi

