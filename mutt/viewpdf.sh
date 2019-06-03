#!/bin/bash

# Last update: 2019-06-03, 14:29:39 @toshiba
# Doc:         open pdf in mutt

DATE=$(date "+%m%d%H%M")
cp "$1" /tmp/$DATE-mutt.pdf && zathura /tmp/$DATE-mutt.pdf

