#!/bin/bash

# Path:        ~/.dotfiles/bin/mypackages.sh
# Created:     16.06.18, 15:15    @x200
# Last update: 17.06.18, 02:29:24 @lenovo

# Doc:

packages="emacs tmux neomutt moc ranger i3-gaps i3blocks aspell aspell-pl r ditaa fzf docx2txt unrtf mpv gpick dropbox firefox dmenu rofi pulseaudio newsboat python-pip youtube-dl calcurse w3m compton transset-df gimp pacman-contrib acpi"

for x in $packages; do
    if pacman -Qs $x > /dev/null ; then
        echo "$x jest zainstalowana" >> ~/packages-log.txt
    else
        echo "instaluję $x" >> ~/packages-log.txt
        pacman -S $x
    fi
done

#git clone https://github.com/caseneuve/st ~/suckless
#git clone https://github.com/caseneuve/emacs ~/.emacs.d/
    
