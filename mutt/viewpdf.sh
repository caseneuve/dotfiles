#!/bin/bash

# Last update: 02.02.18, 15:39:04 @x200

# Doc: skrypt wykonawczy dla mutt'a

i3-msg 'workspace 5' && mupdf "$1" && i3-msg workspace number 10
