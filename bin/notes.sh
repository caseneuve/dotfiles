#!/bin/bash
# Last update: 30.07.18, 00:38:35 @x200
# Doc: dodaje wpis do notesu z dp, który jest symlinkowany do każdej maszyny

NOTES=~/org/quicknotes.txt

printf "* $(date) @$HOSTNAME -- " >> $NOTES
emacsclient -nw +10000 $NOTES

