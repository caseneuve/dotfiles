#!/bin/bash

# Path:        ~/.dotfiles/bin/update-local.sh
# Created:     22.03.18, 23:21    @manjaroi3
# Last update: 03.04.18, 16:43:51 @lenovo

# Doc: tymczasowe apdejty

echo "Tworzę symlinlik dla mutt_color"
ln -s ~/.dotfiles/mutt/mutt_color ~/.mutt/schemes/mutt_color
echo "$(ls -l ~/.mutt/schemes)"

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
    
