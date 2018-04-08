#!/bin/bash
# Last update: 08.04.18, 15:09:21 @x200
# Doc: dodaje wpis do notesu z dp, który jest symlinkowany do każdej maszyny

printf "* $(date) @$HOSTNAME -- " >> ~/notes.txt
emacsclient -nw +1000 ~/notes.txt

