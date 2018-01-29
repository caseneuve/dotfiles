# ~/.dotfiles/Boot-ex/goobook.sh
# Created:     16.01.18, 10:02    @x200
# Last update: 16.01.18, 10:13:28 @x200

# Doc: instaluje goobok (potrzebne dla mutt) i odpala komendę authenticate

#!/bin/bash

package1=goobook-git
indir=$HOME/biurko/aur/goobook/

# sprawdź, czy urlview jest zainstalowana
if pacman -Qi "$package1" &>/dev/null; then
    echo "Paczka $(pacman -Q "$package1") jest zainstalowana."; exit 0
else
    git clone https://aur.archlinux.org/goobook-git.git $indir  && \
        cd $indir && \
        makepkg -si --noconfirm && \
        echo "Zainstalowałem paczkę $(pacman -Q "$package1")."
fi

echo "Odpalam komendę 'authenticate' (powinna otworzyć się przeglądarka)."

goobook authenticate
