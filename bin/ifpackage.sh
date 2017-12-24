#!/bin/bash
#YEL=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)
BOLD=$(tput bold)
package=$1

if pacman -Qi $package &> /dev/null ; then
  echo "Paczka $(pacman -Q $package) jest zainstalowana, znajdziesz ją tu: $(which $package)" 
else
    while true; do
        read -p "${BOLD}${RED}### Paczka $package nie jest zainstalowana, czy chcesz ją teraz zainstalować? [t/n] ###${RESET} " yn
        case $yn in
            [Tt]* ) sudo pacman -S $package; break;;
            [Nn]* ) exit;;
            * ) echo "${BOLD}${RED} Wpisz [Tt/Nn] :${RESET} ";;
        esac
    done
fi
