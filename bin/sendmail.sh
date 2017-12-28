#!/bin/bash

clear

read -p "Do kogo chcesz wysłać wiadomość? " mailaddress
read -p "Temat wiadomości: " subject
read -p "Treść wiadomości: " body

if [ -z "$1" ]; then
echo "$body" | mutt -s "$subject" $mailaddress;
else
echo "$body" | mutt -s "$subject" $mailaddress -a "$@";
fi
