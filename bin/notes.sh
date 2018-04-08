#!/bin/bash

# Last update: 08.04.18, 12:52:46 @manjaroi3

# Doc:
# kasuje stary notes i otwiera czysty do nadpisania, który będzie 
# istniał (jeśli zapisany) do następnego wywołania komendy

#rm ~/notes.txt
printf "* $(date) @$HOSTNAME\n" >> ~/notes.txt
emacsclient -nw +1000 ~/notes.txt

