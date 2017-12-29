# ~/.dotfiles/Boot-ex/xfce4-color.sh
# Created:     29.12.17, 19:33    @x200
# Last update: 29.12.17, 19:56:08 @x200

# Doc: skopiuj moje schematy kolorów do ~/.config/xfce4/terminal/colorschemes/

#!/bin/bash
coldir=$HOME/.config/xfce4/terminal/colorschemes
dotco=$HOME/.dotfiles/xfce4-terminal/colorschemes
if [ -d "$coldir" ] ; then
    ln -s $dotco/* $coldir
else
    mkdir $coldir
    ln -s $dotco/* $coldir
fi

echo "Aktualizacja kolorów dla xfce4 terminala przez skrypt xfce4-color.sh, $(date "+%d.%m.%y, %H:%S")" >> $HOME/.config/xfce4/log.txt

echo "Utworzyłem następujące symlinki:"
ls -l --color=always $coldir
