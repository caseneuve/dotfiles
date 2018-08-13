#!/bin/bash

# Path:        ~/.dotfiles/bin/quick-updates.sh
# Created:     13.08.18, 14:32    @x200
# Last update: 13.08.18, 21:06:28 @x200

# >> DOC: sync config at all machines
# >> LOG:
# 13/08/2018:
# todo: [ ] toshiba; [ ] lenovo
# maim; cronie;

# >> PRINT INFO
LAST_UPD=$(awk 'NR==5 {print $(NF)}' ~/.dotfiles/bin/conf-sync.sh)
echo -e "### Syncing configs with ${LAST_UPD:1}..."

# >> install packages:
declare -a INST_PKG=("maim" "cronie")
echo -e "# Packages: "

for package in "${INST_PKG[@]}"
do
    if pacman -Qi $package &> /dev/null ; then
        echo -e " - Package $(pacman -Q $package) is already installed" 
    else
        while true; do
            read -p " - Package $package missing, do you want to install it now? [y/n] " yn
            case $yn in
                [Yy]* ) sudo pacman -S --noconfirm $package;;
                [Nn]* ) break;;
                * ) echo "Answer [Yy/Nn] : ";;
            esac
        done
    fi
done

# >> symlinks
echo "# Syncing symlinks for:"
IPY_CONF=~/.ipython/profile_default/ipython_config.py
IPY_DOT=~/.dotfiles/ipython/ipython_config.py
[[ -f $IPY_CONF ]] && rm $IPY_CONF
ln -s $IPY_DOT $IPY_CONF && echo " - $(basename $IPY_DOT)"

ROFI_SCR=~/.config/rofi/scripts/translate
ROFI_DOT=~/.dotfiles/rofi/scripts/rofi-translate.py
[[ -f $ROFI_SCR ]] && rm $ROFI_SCR
ln -s $ROFI_DOT $ROFI_SCR && echo " - $(basename $ROFI_DOT)"

THIS=~/.dotfiles/bin/conf-sync.sh
THIS_BIN=~/bin/conf-sync
[[ -f $THIS_BIN ]] && rm $THIS_BIN
ln -s $THIS $THIS_BIN && echo " - $(basename $THIS)"

# >> TODO REMAINDER
echo "## TODO:
 - przeinstalować paczki pythona przez pipa (len/tosh)
"

