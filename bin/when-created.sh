#!/bin/bash

# Path:        ~/.dotfiles/bin/when-created.sh
# Created:     2019-03-02, 21:46    @x200
# Last update: 2019-03-02, 22:17:06 @x200
# Doc:         check when file given as argument was created (execute as root)

[[ ! -f ${1} ]] && echo "Specify file to check" && exit 1
[[ "$EUID" -ne 0 ]] && echo "Please run as root" && exit 1


INODE=$(stat -c %i "$1")
DEVICE=$(df . | awk '/^\// {print $1}')

CRTIME=$(debugfs -R "stat <${INODE}>" $DEVICE 2>&1 |\
             awk '/^crtime/ {print toupper ($6 " " $5 " " $8 " " $7)}')
DATE=$(date -d "$CRTIME" +%Y-%m-%d' '%H:%M:%S)
echo -e "file:    $1\ncreated: $DATE"

