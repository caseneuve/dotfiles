# ~/.dotfiles/Boot-ex/mutt-boot.sh
# Created:     29.12.17, 17:39    @lenovo
# Last update: 29.12.17, 18:18:02 @lenovo

# Doc: Sprawdź, czy mutt jest zainstalowany, następnie ściągnij konfig z .dotfiles

#!/bin/bash

package=mutt
confdir=$HOME/.mutt
dotmt=$HOME/.dotfiles/mutt

clear

if pacman -Qi $package &> /dev/null ; then
    echo "Paczka $(pacman -Q $package) jest zainstalowana." 
else
    sudo pacman -S --noconfirm neomutt &&\
        echo "Zainstalowałem paczkę $(pacman -Q $package)."
fi

if [ -d $confdir ] ; then
    while true; do
        read -p "Wyczyszczę pliki konfiguracyjne z $confdir, kontynuować? [t/n] " dec
        case $dec in
            [Tt]* ) cd $confdir; rm -rf kbd.conf mailcap muttimage.sh viewimagefeh.sh viewpdf.sh; break;;
            [Nn]* ) echo 'Przerywam skrypt mutt-boot!'; exit 0;;
            * ) echo 'Wpisz [t/n]';;
        esac
    done
else
    mkdir $confdir
fi

ln -s $dotmt/* $confdir &>/dev/null
rm $confdir/muttrc
rm $HOME/.muttrc
ln -s $dotmt/muttrc $HOME/.muttrc

if [ ! -d $confdir/schemes ] ; then
    mkdir $confdir/schemes
fi

rm $confdir/schemes/manjaro-color
ln -s $HOME/Dropbox/config/mutt/manjaro-color $confdir/schemes

echo "Konfiguracja zaktualizowana przez skrypt mutt-boot.sh $(date "+%d.%m.%y, %H:%M")" >> $confdir/log.txt

printf "\nSukces, konfiguracja $(pacman -Q $package) została zaktualizowana!\n$(cd $HOME; pwd; ls -la --color=always | grep muttrc)\n$(cd $confdir; pwd; ls -l --color=always)\n$(cd $confdir/schemes; pwd; ls -l --color=always)\n"
