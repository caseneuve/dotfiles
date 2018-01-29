# ~/.mutt/goobook.sh
# Created:     15.01.18, 13:04    @x200
# Last update: 15.01.18, 13:09:13 @x200

# Doc: adds sender to google contacts, reloads goobook

#!/bin/bash
goobook add $1 && goobook reload
