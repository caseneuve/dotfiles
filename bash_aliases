# ~/.dotfiles/bash_aliases
# Created:     ?
# Last update: 29.01.18, 20:41:43 @x200

# ALIASY 

# vars
home=/home/piotr

# komendy terminala
alias q=exit
alias cl=clear
alias cls=clear
alias klr=clear
alias la='ls -a'
alias ll='ls -l'
alias cdl='cd $1;ls'
alias 'cd.'='cd ..'
alias '..'='cd ..'
alias lg='ls --group-directories-first'
alias lag='ls -a --group-directories-first'
alias kl=pkill

# funkcje
cdls() { cd "$@" && ls; }

mk()
{
    mkdir -p -- "$1" &&
    ls -a --group-directories-first
}

mkc()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# polecenia
alias sbr='source ~/.bashrc'
alias cfg='emacsclient -nw /home/piotr/.dotfiles/i3/config'
alias nba='nano --nohelp ~/.bash_aliases'
alias nbr='nano --nohelp ~/.bashrc'
alias nco='nano --nohelp ~/.compton.conf'
alias PSyyu='sudo pacman -Syyu'
alias sp='sudo pacman -S'
alias spR='sudo pacman -Rs'
alias ya='yaourt --noconfirm'
alias nlog='date >> /home/piotr/.log-antergos; nano --nohelp /home/piotr/.log-antergos'
alias yta='youtube-dl --extract-audio --audio-format mp3'
alias nmt='nano ~/.muttrc'
alias ntm='nano ~/.config/termite/config'
alias ntx='nano ~/.tmux.conf'
alias ch7='chmod 750 $1'

alias eba='emacsclient -nw  ~/.bash_aliases'
alias ebr='emacsclient -nw  ~/.bashrc'
alias eco='emacsclient -nw  ~/.compton.conf'
alias elog='date >> /home/piotr/.log-antergos; emacsclient -nw  /home/piotr/.log-antergos'
alias emt='emacsclient -nw ~/.muttrc'
alias etm='emacsclient -nw ~/.config/termite/config'
alias etx='emacsclient -nw ~/.tmux.conf'
alias eno='emacsclient -nw /home/piotr/Dropbox/EMACS/notes.org'
alias e='emacsclient -nw'


# programy 
alias e="emacsclient -nw -c $1"
alias r=ranger
alias m=mocp 
alias f=feh
alias n='nano --nohelp'
alias nl='nano -l --nohelp'
alias qb=qutebrowser
alias v=mpv
alias mpva='mpv --no-video'
alias va='mpv --no-video'
alias vl='mpv --playlist=/home/piotr/Wideo/playlist &'
alias c=calcurse
alias clc=gcalccmd
alias kal='cal -s --color'
alias hg=hangups 
alias mp=mupdf
alias mu=mupdf
alias mt='cd ~/Pobrane; mutt'
alias nf='clear; neofetch'

# system info / akcje
alias bat='upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"'

# skrypty
alias wall='/home/piotr/.dotfiles/bin/wall.sh'
alias walp='/home/piotr/.dotfiles/bin/walp.sh' 
alias drop='/home/piotr/.dotfiles/bin/dropdown.sh'
alias tnij='/home/piotr/.dotfiles/bin/tnijpdf.sh'
alias off='/home/piotr/.dotfiles/bin/poweroff.sh'
alias mnt='/home/piotr/.dotfiles/bin/mount.sh'
alias umnt='/home/piotr/.dotfiles/bin/unmount.sh'
alias hmupdf='/home/piotr/.bin/mupdfhelp.sh'
alias bhelp='/home/piotr/.bin/bashhelp.sh'
alias hbash='/home/piotr/.bin/bashhelp.sh'
alias Ap='/home/piotr/.dotfiles/bin/i3append.sh'
alias apd='/home/piotr/.dotfiles/bin/append.sh'
alias pif=$home/.dotfiles/bin/ifpackage.sh
alias sm=$home/.dotfiles/bin/sendmail.sh
alias kbd=$home/.dotfiles/bin/kbd-help.sh
alias update=/home/piotr/.dotfiles/bin/update.sh
alias monitory='/home/piotr/.dotfiles/bin/monitoryL.sh'
alias monitL='/home/piotr/.dotfiles/bin/monitoryL.sh'
alias monitR='/home/piotr/.dotfiles/bin/monitoryR.sh'
alias monitory2='/home/piotr/.dotfiles/bin/monitory-duplicate.sh'
alias notes='/home/piotr/.dotfiles/bin/notes.sh'
alias nt='/home/piotr/.dotfiles/bin/notes.sh'
alias update='/home/piotr/.dotfiles/bin/update.sh'

# zmienne
muz=/home/piotr/Muzyka
pod=/home/piotr/Pobrane
dot=/home/piotr/.dotfiles
moc=/home/piotr/.moc
pob=/home/piotr/Pobrane
obr=/home/piotr/Obrazy
wid=/home/piotr/Wideo

# git
alias gts='/home/piotr/.dotfiles/bin/gitstatus.sh'
alias push='/home/piotr/.dotfiles/bin/gitpush.sh'
alias pull='/home/piotr/.dotfiles/bin/gitpull.sh'
alias gta='git add'
alias gtc='git commit -m'

# fast dirs start

alias gh='cd /home/piotr'
alias ga='cd /home/piotr/Pobrane'
alias go='cd /home/piotr/Obrazy'
alias gw='cd /home/piotr/Wideo'
alias gm='cd /home/piotr/Muzyka'
alias gp='cd /home/piotr/pdf'
alias gb='cd /home/piotr/biurko'
alias gS='cd /home/piotr/Szkoła'
alias gP='cd /home/piotr/Pulpit'
alias gk='cd /home/piotr/Książki'
alias gy='cd /home/piotr/Dokumenty'
alias gc='cd /home/piotr/.config'
alias gcr='cd /home/piotr/.config/ranger'
alias gct='cd /home/piotr/.config/termite'
alias gcx='cd /home/piotr/.config/xfce4'
alias gcb='cd /home/piotr/.bak'
alias gC='cd /home/piotr/.calcurse'
alias gd='cd /home/piotr/.dotfiles'
alias gdd='cd /home/piotr/.dotfiles'
alias gdb='cd /home/piotr/.dotfiles/bin'
alias gdi='cd /home/piotr/.dotfiles/i3'
alias gdr='cd /home/piotr/.dotfiles/ranger'
alias gdc='cd /home/piotr/.dotfiles/calcurse'
alias gx='cd /home/piotr/Dropbox'
alias gxx='cd /home/piotr/Dropbox'
alias gxc='cd /home/piotr/Dropbox/config'
alias gxl='cd /home/piotr/Dropbox/linux'
alias gxp='cd /home/piotr/Dropbox/linux/pdf'
alias ge='cd /home/piotr/Dropbox/EMACS'
alias gs='cd /home/piotr/Dropbox/EMACS/szkoła'
alias geg='cd /home/piotr/.emacs.git'
alias ged='cd /home/piotr/.emacs.d'
alias gcm='cd /home/piotr/.mutt'
alias gdx='cd /home/piotr/.dotfiles/Boot-ex'
alias gM='cd /media'
alias gr='cd /'
alias gR='cd /root'

# fast dirs end

