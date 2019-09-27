#!/bin/bash

# Path:        ~/.dotfiles/bin/pdfcut_jam.sh
# Created:     2018-10-18, 23:40    @lenovo
# Last update: 2019-09-26, 08:48:58 @lenovo
# Doc:         intelligently cut pdfs (used in ranger)

# if pacman -Qs pdfjam > /dev/null ; then
#     # set output title
#     if [[ $# > 2 ]]; then
#         [[ "$3" == *".pdf" ]] && out="$3" || out="$3.pdf"
#     else
#         out="${1%.pdf}"_$2.pdf
#     fi
#     # check pdf orientation
#     opt=$(
#         pdfinfo "$1" |\
#             awk '/Page size:/ {if ($3 > $5) print "--landscape"}'
#        )
#     # run cut command
#     pdfjam "$1" "$2" -o "$out" $opt
# else
#     echo "pdfjam not installed" && exit 1
# fi


if [[ $# > 2 ]]; then
    [[ "$3" == *".pdf" ]] && out="$3" || out="$3.pdf"
else
    out="${1%.pdf}"_$2.pdf
fi
# check pdf orientation
opt=$(
    pdfinfo "$1" |\
        awk '/Page size:/ {if ($3 > $5) print "--landscape"}'
   )
# run cut command
pdfjam "$1" "$2" -o "$out" $opt
