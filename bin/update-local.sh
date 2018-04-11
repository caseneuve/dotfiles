#!/bin/bash

# Path:        ~/.dotfiles/bin/update-local.sh
# Created:     22.03.18, 23:21    @manjaroi3
# Last update: 11.04.18, 23:06:59 @x200

# Doc: tymczasowe apdejty
# general settings (do not delete me)
RED=$(tput setaf 1)
RESET=$(tput sgr0)
BOLD=$(tput bold)
YEL=$(tput setaf 3)
echo "${BOLD}${RED}### Running Update... ###${RESET}"

# 11/04/2018
# ranger
echo "${YEL}Tworzę symlink dla commands.py (ranger)${RESET}"
rm ~/.config/ranger/commands.py
ln -s ~/.dotfiles/ranger/commands.py ~/.config/ranger/commands.py
if [ -L ~/.config/ranger/commands.py ]; then
    echo -e "Zrobione.\n"
    echo "$(date) >> Utworzyłem symlink dla ~/.config/ranger/commands.py" >> .update-log
else
    echo "$(date) >> ERROR: nie utworzyłem symlinka dla ~/.config/ranger/commands.py" >> ~/.update-log
    echo -e "Błąd.\n"
fi


# newsboat
packagenb=newsboat
echo "${YEL}Sprawdzam, czy mam $packagenb${RESET}"
if pacman -Qi $packagenb &> /dev/null ; then
  echo -e "Paczka $(pacman -Q $packagenb) jest zainstalowana, znajdziesz ją tu: $(which $packagenb)\n" 
else
    sudo pacman -S --no-confirm $packagenb;
    echo -e "Zainstalowałem $packagenb\n"
    echo "$(date) >> Zainstalowałem $packagenb" >> ~/.update-log
fi

echo "${YEL}Tworzę symlinki dla newsboat${RESET}"
filenb=~/.newsboat/config
cd ~/.newsboat
if [ -f ~/.newsboat/config ]; then
    rm $filenb
    ln -s ~/.dotfiles/newsboat/config ~/.newsboat
    echo -e "Zrobione\n"
else
    if ! [ -d ~/.newsboat ]; then
        mkdir ~/.newsboat
    fi
    ln -s ~/.dotfiles/newsboat/config ~/.newsboat
    echo -e "Zrobione\n"
fi
if [ -L ~/.newsboat/config ]; then
    echo "$(date) >> Utworzyłem symlink dla ~/.newsboat/config" >> ~/.update-log
else
    echo "$(date) >> ERROR: nie utworzyłem symlinka dla ~/.newsboat/config" >> ~/.update-log
    echo -e "Błąd.\n"
fi
cd ~

# 08/04/2018 ?
# if [ -f ~/.urlview ]; then
#     rm ~/.urlview
#     echo "${YEL}Tworzę symlink dla .urlview${RESET}"
#     ln -s ~/.dotfiles/urlview ~/.urlview
# else
#     echo "Tworzę symlink dla .urlview"
#     ln -s ~/.dotfiles/urlview ~/.urlview
# fi
# if [ -L ~/.urlview ]; then
#     echo -e "Zrobione\n"
# else
#     echo "Błąd.\n"
# fi

if pacman -Qi weechat &> /dev/null ; then
    echo "${YEL}Usuwam paczkę: weechat${RESET}"
    sudo pacman -R weechat
    if [ -d ~/.weechat ]; then
        rm -rf ~/.weechat
    fi
    echo "Usunąłem weechat"
    echo "$(date)Usunąłem weechat" >> ~/.update-log
fi

# 08/04/2018
# mkdir qtb (for qutebrowser)
dirs="/home/piotr/Wideo/qtb /home/piotr/Muzyka/qtb"

for dir in $dirs
do
    if ! [ -d "$dir" ]; then
        mkdir -p $dir
    fi
done

echo -e "\n" >> ~/.update-log

# archiwizuję: 04/04/2018
# echo "Tworzę symlinlik dla mutt_color"
# ln -s ~/.dotfiles/mutt/mutt_color ~/.mutt/schemes/mutt_color
# echo "$(ls -l ~/.mutt/schemes)"

# ==================================================
# archiwizuję: 03/04/2018
# package1=fzf
# package2=fd

# if [ -f ~/.fzf.bash -o -L ~/.fzf.bash ]; then
#     echo "Paczka $(pacman -Q $package1) jest zainstalowana, znajdziesz ją tu: $(which $package1) (??), sprawdź też katalog ~/.fzf ." 
# else
#     echo "Instaluję FUZZY FINDERA."
#     git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &&\
#         ~/.fzf/install
#     echo "Usuwam defoltowy plik .fzf.bash i tworzę symlinka do .dotfiles/fzf/fzf.bash ."
#     rm ~/.fzf.bash
#     ln -s ~/.dotfiles/fzf/fzf.bash ~/.fzf.bash
#     . ~/.bashrc
# fi

# if pacman -Qi $package2 &> /dev/null ; then
#     echo "Paczka $(pacman -Q $package2) jest zainstalowana, znajdziesz ją tu: $(which $package2)."
# else
#     echo "Instaluję $package2."
#     sudo pacman -S $package2
#     if pacman -Qi $package2 &> /dev/null ; then
#         echo "Paczka $(pacman -Q $package2) została zainstalowana, znajdziesz ją tu: $(which $package2)."
#     else
#         echo "Nie udało się zainstalować $package2."
#     fi
# fi

# ==================================================
# archiwizuję: 29/03/2018
# file8=$HOME/.config/hangups/hangups.conf
# sym8=$HOME/.dotfiles/hangups.conf
# hdir=$HOME/.config/hangups

# printf ">> Sprawdzam, czy istnieje powiązanie do pliku: $sym8\n"
# if ! [ -d $hdir ]; then
#     mkdir $hdir
#     echo ">> Utworzyłem folder: $hdir."
# else
#     echo ">> Folder: $hdir istnieje."
# fi

# if ! [ -L $file8 ]; then
#     rm $file8
#     ln -s $sym8 $hdir
#     echo ">> Utworzyłem symlink do: $sym8."
# else
#     echo ">> Symlink istnieje."
# fi
    
