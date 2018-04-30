#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

sudo mount /dev/sdb1 /media && \
clear
printf "${bold}Zamontowałem USB:${normal}\n\nNAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT\n--------------------------------------------\n$(lsblk | grep "sdb1")\n\n"
ls -a --color=auto --group-directories-first /media
