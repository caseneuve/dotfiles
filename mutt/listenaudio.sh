#!/bin/bash

# Last update: 2019-06-03, 14:31:43 @toshiba

DATE=$(date "+%m%d%H%M")
cp "$1" /tmp/$DATE-mutt.mp3 && mocp -l /tmp/$DATE-mutt.mp3

