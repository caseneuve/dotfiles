#!/bin/bash

# Last update: 28.01.18, 17:13:11 @x200

# Doc:
# kasuje stary notes i otwiera czysty do nadpisania, który będzie 
# istniał (jeśli zapisany) do następnego wywołania komendy

#rm ~/notes.txt
printf "* $(date)\n" >> ~/notes.txt
emacsclient -nw +1000 ~/notes.txt

