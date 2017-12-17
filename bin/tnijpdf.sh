#!/bin/bash

# problem: skrypt nie widzi input file, jeśli są spacje w nazwie...
# solved: należy wziąć zeminną w cudzysłów 

YEL='\033[1;33m' # yellow
NC='\033[0m'     # no color

pdftk "$1" cat $2 output $3
printf "${YEL}### Utworzyłem plik: ###${NC}\n"; ls "$3"
