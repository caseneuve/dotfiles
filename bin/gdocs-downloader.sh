#!/bin/bash

# Path:        ~/scr/gdocs.sh
# Created:     28.12.18, 15:20    @x200
# Last update: 2019-11-09, 22:10:13 @lenovo
# Dox:         Downloads file from Google Docs in a chosen format (html or txt); when 

OUTDIR="$HOME/dwl/gdoc"
ROFI_ARGS="-theme i3on-window -monitor -2 -dmenu -p"

answ=$(echo -e "tak\nnie" | rofi $ROFI_ARGS "Zapisać plik na dysku? ")
if [[ $answ =~ n ]]; then
    qutebrowser "$1" > /dev/null &
else
    mkdir -p ~/dwl/gdoc
    form=$(echo -e "html\ntxt" | rofi $ROFI_ARGS "Wybierz format: ")
    LINK="${1%/*}/export?format=$form"
    FILE=$(date '+%y%m%d_%H%M%S_GDocs')
    wget $LINK -O ~/dwl/gdoc/$FILE.$form > /dev/null
    if [[ $form == html ]]; then
        pandoc -o "$OUTDIR/$FILE.org" -f html -t org "$OUTDIR/$FILE.html" > /dev/null
        [[ -f ~/dwl/gdoc/$FILE.org ]] && notify-send "URLVIEW" "File $FILE.$form downloaded and converted to ORG!"
    else
        [[ -f ~/dwl/gdoc/$FILE.$form ]] && notify-send "URLVIEW" "File $FILE.$form downloaded!"
    fi
fi

