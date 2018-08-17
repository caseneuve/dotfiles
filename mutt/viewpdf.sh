#!/bin/bash

# Last update: 17.08.18, 14:45:17 @x200

# Doc: skrypt wykonawczy dla mutt'a

WS_PDF=$(i3-msg -t get_config | grep 'set \$ws5' | awk '{print $3 " " $4}')
WS_MAIL=$(i3-msg -t get_config | grep 'set \$ws10' | awk '{print $3 " " $4}')

i3-msg -q "$WS_PDF" && mupdf "$1" 
i3-msg -q "$WS_MAIL"

