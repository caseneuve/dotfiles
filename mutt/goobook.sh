# ~/.mutt/goobook.sh
# Created:     15.01.18, 13:04    @x200
# Last update: 04.04.18, 20:35:35 @manjaroi3

# Doc: adds sender to google contacts, reloads goobook

#!/bin/bash
goobook add $1 && goobook reload

