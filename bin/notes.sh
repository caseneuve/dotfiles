#!/bin/bash
# Last update: 2019-03-23, 19:35:04 @toshiba
# Doc: dodaje wpis do notesu z dp, który jest symlinkowany do każdej maszyny

NOTES=~/org/quicknotes.txt

printf "* [$(date +'%d %b %Y, %H:%M') @$HOSTNAME] -- " >> $NOTES
$EDITOR +10000 $NOTES
