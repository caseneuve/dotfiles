# ~/.dotfiles/Boot-ex/tmux-boot.sh
# Created:     29.12.17, 16:49    @lenovo
# Last update: 29.12.17, 23:15:25 @x200

# Doc: Aktualizuje wtyczki dla tmuxa i tworzy plik konfiguracyjny z moimi kbd

#!/bin/bash

package1=urlview
package2=tmux
confdir=$HOME/.tmux/
confile=$HOME/.tmux.conf

# sprawdź, czy urlview jest zainstalowana
if pacman -Qi "$package1" &>/dev/null; then
    echo "Paczka $(pacman -Q "$package1") jest zainstalowana."
else
    git clone https://aur.archlinux.org/urlview.git $HOME/biurko/aur/urlview && \
        cd $HOME/biurko/aur/urlview && \
        makepkg -si --noconfirm && \
        echo "Zainstalowałem paczkę $(pacman -Q "$package1")."
fi

# popraw plik wykonawczy dla urlview
if [ -z "$(cat /etc/urlview/system.urlview | grep firefox)" ]; then
    echo "Dopisuję komendę wykonawczą do urlview:"
    sudo sed -i 's/COMMAND url_handler.sh/#COMMAND url_handler.sh/g' /etc/urlview/system.urlview
    echo "COMMAND firefox %s" | sudo tee -a /etc/urlview/system.urlview
fi

# sprawdź, czy tmux jest zainstalowany
if pacman -Qi "$package2" &>/dev/null; then
    echo "Paczka $(pacman -Q "$package2") jest zainstalowana."
else
    sudo pacman -S --noconfirm $package2 &&\
        echo "Zainstalowałem paczkę $(pacman -Q "$package2")."
fi

# usuń folder ~/.tmux, jeśli istnieje
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

# usuń ~/.tmux.conf, jeśli istnieje 
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

# utwórz symlink 
ln -s $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf

# zainstaluj pluginy
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-urlview ~/.tmux/plugins/tmux-urlview
tmux source-file ~/.tmux.conf

# info
echo "Konfiguracja tmuxa zainstalowana przez skrypt termite-boot.sh $(date "+%d.%m.%y, %H:%M") wraz z zależnościami: $(pacman -Q urlview)" >> $HOME/.tmux/log.txt

printf "\nSukces, zainstalowałem $(pacman -Q urlview), utworzyłem $(ls -la --color=always ~ | grep tmux)\n"
