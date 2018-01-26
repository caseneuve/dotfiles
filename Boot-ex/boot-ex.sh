#!/bin/bash

# ~/.dotfiles/Boot-ex/boot-ex.sh
# Created:     29.12.17, 18:20    @lenovo
# Last update: 26.01.18, 10:55:01 @x200

# Doc: Wykonuje kolejno skrypty aktualizujące konfigurację dla:
# 1. tmux
# 2. termite
# 3. mutt

bodir=$HOME/.dotfiles/Boot-ex

printf "Aktualizuję tmux\n"
$bodir/tmux-boot.sh

printf "Aktualizuję termite\n"
$bodir/termite-boot.sh

printf "Aktualizuję mutt\n"
$bodir/mutt-boot.sh
