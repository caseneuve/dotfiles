#!/bin/bash

# Last update: 2019-04-21, 00:02:07 @lenovo
# Doc:         open pdf in mutt

WS_PDF=$(i3-msg -t get_config | grep 'set \$ws5' | awk '{$1=$2=""; print}')
i3-msg -q "$WS_PDF" && mupdf "$1" 

