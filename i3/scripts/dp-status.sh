#!/bin/bash

GLYPH=""
FGCOLOR="#ff5252"

[[ -n $(pgrep dropbox) ]] || echo "<span color='$FGCOLOR'> $GLYPH </span>"
