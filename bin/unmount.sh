#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

usb=$(lsblk | grep -o "sdb1")

sudo umount /media &&\
printf "Odłączyłem USB ${bold}$usb${normal}.\n"
