#!/bin/bash

# kasuje stary notes i otwiera czysty do nadpisania, który będzie 
# istniał (jeśli zapisany) do następnego wywołania komendy

rm ~/notes.txt
date > ~/notes.txt
nano ~/notes.txt
