#!/bin/bash

# Last update: 2019-04-20, 18:09:48 @lenovo
# Doc:         open pdf in mutt

WS_PDF=$(i3-msg -t get_config | grep 'set \$ws5' | awk '{print $3 " " $5}')
i3-msg -q "$WS_PDF" && mupdf "$1" 

