#!/bin/bash

# Last update: 11.07.18, 17:35:24 @x200

# Doc: skrypt wykonawczy dla mutt'a

i3-msg 'workspace 5' && mupdf "$1" && i3-msg workspace number 10

