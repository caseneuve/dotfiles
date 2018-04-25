# Last update: 25.04.18, 22:03:56 @x200

#!/bin/bash

clear

read -p "Do kogo chcesz wysłać wiadomość? " mailaddress
read -p "Temat wiadomości: " subject
read -p "Treść wiadomości: " body

if [ -z "$1" ]; then
echo "$body" | mutt -s "$subject" $mailaddress > /dev/null 2>&1 
else
echo "$body" | mutt -s "$subject" $mailaddress -a "$@" > /dev/null 2>&1 
fi

