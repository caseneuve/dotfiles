#!/bin/env python

# Path:        ~/.dotfiles/i3/scripts/i3mail-decode.py
# Created:     2019-04-22, 11:42    @x200
# Last update: 2019-04-22, 11:51:30 @x200
# Doc:

import email.header, sys

encoded = sys.argv[1]
try:
    words = email.header.decode_header(encoded)
    words = [s.decode(c or "utf-8") for (s, c) in words]
except:
    words = encoded

print("".join(words))
