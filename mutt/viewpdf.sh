#!/bin/bash

i3-msg 'workspace 5: ' && mupdf "$1" && i3-msg workspace number 10
