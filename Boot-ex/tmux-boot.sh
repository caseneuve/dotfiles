# ~/.dotfiles/Boot-ex/tmux-boot.sh
# Created:     29.12.17, 16:49    @lenovo
# Last update: 29.12.17, 17:43:36 @lenovo

# Doc: Aktualizuje wtyczki dla tmuxa i tworzy plik konfiguracyjny z moimi kbd

#!/bin/bash

package1=urlview
package2=tmux
confdir=$HOME/.tmux/
confile=$HOME/.tmux.conf

clear

if [ ! pacman -Qi "$package1" &> /dev/null ] ; then
    yaourt -S --noconfirm $package1 &&\
        echo "Zainstalowałem paczkę $(pacman -Q "$package1")."
else
    echo "Paczka $(pacman -Q "$package1") jest zainstalowana."
fi

if [ ! pacman -Qi "$package2" &> /dev/null ] ; then
    sudo pacman -S --noconfirm $package2 &&\
        echo "Zainstalowałem paczkę $(pacman -Q "$package2")."
else
    echo "Paczka $(pacman -Q "$package2") jest zainstalowana."
fi

if [ -d "$confdir" ]; then
    while true; do
        read -p "Usunę folder '$confdir'. Kontynuować? [t/n] " dec
        case $dec in
            [Tt]* ) rm -rf $confdir; break;;
            [Nn]* ) echo 'Przerywam tmux-boot skrypt!'; exit 0;;
            * ) echo 'Wpisz [t/n]';;
        esac
    done
fi

if [ -f "$confile" ]; then
    while true; do
        read -p "Usunę plik '$confile' Kontynuować? [t/n] " dec
        case $dec in
            [Tt]* ) rm -rf $confile; break;;
            [Nn]* ) echo 'Przerywam tmux-boot skrypt!'; exit 0;;
            * ) echo 'Wpisz [t/n]';;
        esac
    done
fi

ln -s $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-urlview ~/.tmux/plugins/tmux-urlview
tmux source-file ~/.tmux.conf

echo "Konfiguracja tmuxa zainstalowana przez skrypt termite-boot.sh $(date "+%d.%m.%y, %H:%M") wraz z zależnościami: $(pacman -Q urlview)" >> $HOME/.tmux/log.txt

printf "\nSukces, zainstalowałem $(pacman -Q urlview), utworzyłem $(ls -la --color=always ~ | grep tmux)\n"





