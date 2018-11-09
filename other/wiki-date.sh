#!/bin/bash

# Path:        ~/scr/wida.sh
# Created:     09.11.18, 09:17    @toshiba
# Last update: 09.11.18, 11:37:51 @toshiba
# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 
PL=https://pl.wikipedia.org/wiki/Kalendarium_dzie%C5%84_po_dniu
from=".*"
to="2018"
query=".*"
del=

# >> FUNCTIONS:
# >>> usage
usage(){
    cat << EOF
Wiki date: drukuj wydarzenia z bieżącego dnia w terminalu
Usage: wiki-date [-swuz] [-f <nnnn>] [-t <nnnn>] [-q <regex>]

 -s  święta
 -p  wydarzenia w Polsce 
 -w  wydarzenia na świecie
 -u  urodzili się
 -z  zmarli
 -f  from: <YYYY> regex
 -t  to: <YYYY>  regex
 -q  zapytnie do filtrowania
 -v  zapytanie do odrzucenia

EOF
}

# >>> main
main(){
    w3m -cols 9999 -dump $PL | sed -n "/$1/,/$2/ p" | sed 's/^.*• \|□\|\^\[[0-9]\]\|\[edytuj.*$//g' | sed -n "/$3/,/$4/ p" | head -n -1
}


# >> RUN:
if [[ -z $@ ]]; then
    usage
    exit 0
fi

while getopts 'spwuzf:t:q:v:' arg; do
    case $arg in
        q) query="${OPTARG}";;
        v) del="${OPTARG}";;
        f) from="${OPTARG}";;
        t) to="${OPTARG}";;
        s) BEG="^Święta"
           END="Wydarzenia"
           ;;
        p) BEG="^Wydarzenia w Polsce"
           END="^Wydarzenia na"
           ;;
        w) BEG="^Wydarzenia na"
           END="^Zdarzenia"
           ;;
        u) BEG="^Urodzili"
           END="^Zmarli"
           ;;
        z) BEG='^Zmarli'
           END='^Przypisy'
           ;;
        h) usage ;;
    esac
done

if [[ -z $del ]]; then
    main "$BEG" "$END" "$from" "$to" | grep "$query" | grep --color ^[0-9]*
else
    main "$BEG" "$END" "$from" "$to" | grep -v "$del" | grep "$query" | grep --color ^[0-9]*
fi
