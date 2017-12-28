# MOJE ALIASY PK

# komendy terminala
alias q=exit
alias cl=clear
alias cls=clear
alias klr=clear
alias la='ls -a'
alias ll='ls -l'
alias cdl='cd $1;ls'
alias 'cd.'='cd ..'
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
alias cfg='emacsclient -nw -c /home/piotr/.i3/config'
alias nba='nano --nohelp ~/.bash_aliases'
alias nbr='nano --nohelp ~/.bashrc'
alias nco='nano --nohelp ~/.compton.conf'
alias mpva='mpv --no-video'
alias PSyyu='sudo pacman -Syyu'
alias sp='sudo pacman -S'
alias ya='yaourt --noconfirm'
alias nlog='date >> /home/piotr/.log-antergos; nano --nohelp /home/piotr/.log-antergos'
alias yta='youtube-dl --extract-audio --audio-format mp3'

# programy 
alias e="emacsclient -nw -c $1"
alias r=ranger
alias m=mocp 
alias f=feh
alias n='nano --nohelp'
alias nl='nano -l --nohelp'
alias qb=qutebrowser
alias v=mpv 
alias c=calcurse
alias clc=gcalccmd
alias kal='cal -s --color'
alias hg=hangups 
alias mp=mupdf
alias mu=mupdf
alias mt='cd ~/Pobrane; mutt'

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
alias pif=$HOME/.dotfiles/bin/ifpackage.sh

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

# fast dirs
alias gc='cd /home/piotr/.config;ls -a'
alias gd='cd /home/piotr/Pobrane;ls -a'
alias gh='cd ~; ls -a --group-directories-first'
alias home='cd /home/piotr; ls -a --group-directories-first'
alias cdD='cd /home/piotr/.dotfiles;ls -a'
alias cdDb='cd /home/piotr/.dotfiles/bin;ls -a'
alias cdDi='cd /home/piotr/.dotfiles/i3;ls -a'
alias cdO='cd /home/piotr/Obrazy;ls -a'
alias cdC='cd /home/piotr/.config;ls -a'
alias cdM='cd /home/piotr/Muzyka;ls -a'
alias cdW='cd /home/piotr/Wideo;ls -a'
alias cdP='cd /home/piotr/pdf;ls -a'
alias cdA='cd /home/piotr/Pobrane;ls -a'
alias cdC='cd /home/piotr/.config;ls -a'
alias cdS='cd /home/piotr/Szkoła;ls -a'
alias cdB='cd /home/piotr/.dotfiles/bin; ls -a'
alias cdH='cd /home/piotr/.help; ls -a'
alias cdE='cd /home/piotr/Dropbox/EMACS; ls -a --group-directories-first'
alias cdd='cd /home/piotr/Dropbox; ls -a --group-directories-first'
alias cdk='cd /home/piotr/Dokumenty; ls -a --group-directories-first'
alias cdI='cd /home/piotr/.i3; ls -a'

