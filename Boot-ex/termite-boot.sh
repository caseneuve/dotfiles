# ~/.dotfiles/Boot-ex/termite.sh
# Created:     29.12.17, 15:49    @lenovo
# Last update: 29.12.17, 16:48:22 @lenovo

# Doc: Sprawdź, czy termite jest zainstalowany, następnie utwórz symlink do  ~/.config/termite; skrypt zakłada, że na komputerze jest aktywne repo .dotfiles ze ściągniętym folderem /termite/

#!/bin/bash

clear

if [ ! pacman -Qi termite &> /dev/null ] ; then
    sudo pacman -S termite &&\
        echo "Zainstalowałem paczkę $(pacman -Q termite)."
else
    echo "Paczka $(pacman -Q termite) jest zainstalowana."
fi

if [ -d ~/.config/termite ]; then
    while true; do
        read -p 'Usunę folder ~/.config/termite. Kontynuować? [t/n] ' dec
        case $dec in
            [Tt]* ) rm -rf $HOME/.config/termite; break;;
            [Nn]* ) echo 'Przerywam termite-boot skrypt!'; exit 0;;
            * ) echo 'Wpisz [t/n]';;
        esac
    done
fi

mkdir $HOME/.config/termite
ln -s $HOME/.dotfiles/termite/config $HOME/.config/termite/config

echo "Konfiguracja termite zainstalowana przez skrypt termite-boot.sh $(date "+%d.%m.%y, %H:%M")" >> $HOME/.config/termite/log.txt

printf "\nSukces, utworzyłem ~/.config/termite z następującymi plikami:\n\n"

ls -l --color=always $HOME/.config/termite



