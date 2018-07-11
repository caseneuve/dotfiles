#!/bin/bash

# ~/.mutt/goobook.sh
# Created:     15.01.18, 13:04    @x200
# Last update: 11.07.18, 17:32:02 @x200

# Doc: adds sender to google contacts, reloads goobook

goobook add $1 && goobook reload

