#!/bin/bash
# Last update: 11.07.18, 17:19:33 @x200
# Doc: dodaje wpis do notesu z dp, który jest symlinkowany do każdej maszyny

NOTES=~/dox/org/quicknotes.txt

printf "* $(date) @$HOSTNAME -- " >> $NOTES
emacsclient -nw +10000 $NOTES

