#!/bin/bash
# Last update: 28.05.18, 11:09:40 @x200
# Doc: dodaje wpis do notesu z dp, który jest symlinkowany do każdej maszyny

printf "* $(date) @$HOSTNAME -- " >> ~/notes.txt
emacsclient -nw +10000 ~/notes.txt

