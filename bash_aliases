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

# fast dirs
alias gc='cd ~/.config;ls -a'
alias gd='cd ~/Pobrane;ls -a'
alias gh='cd ~; ls -a'
alias home=$HOME
alias cdD='cd ~/.dotfiles;ls -a'
alias cdO='cd ~/Obrazy;ls -a'
alias cdC='cd ~/.config;ls -a'
alias cdDr='cd ~/Dropbox;ls -a'
alias cdM='cd ~/Muzyka;ls -a'
alias cdW='cd ~/Wideo;ls -a'
alias cdP='cd ~/pdf;ls -a'
alias cdA='cd ~/Pobrane;ls -a'
alias cdC='cd ~/.config;ls -a'
alias cdS='cd ~/Szkoła;ls -a'
alias cdB='cd ~/.bin; ls -a'
alias cdH='cd ~/.help; ls -a'
alias cdE='cd ~/Dropbox/EMACS; ls -a --group-directories-first'
alias cdd='cd ~/Dropbox; ls -a --group-directories-first'
alias cdk='cd ~/Dokumenty; ls -a --group-directories-first'

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
alias cfg='emacsclient ~/.i3/config'
alias nba='nano --nohelp ~/.bash_aliases'
alias nbr='nano --nohelp ~/.bashrc'
alias nco='nano --nohelp ~/.compton.conf'
alias mpva='mpv --no-video'
alias PSyyu='sudo pacman -Syyu'
alias sp='sudo pacman -S'
alias ya=yaourt
alias nlog='date >> ~/.log-antergos; nano --nohelp ~/.log-antergos'

# programy 
alias em=emacsclient
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

# system info / akcje
alias bat='upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"'

# skrypty
alias wall='~/.bin/wall.sh'
alias bhelp='~/.bin/bashhelp.sh'
alias hbash='~/.bin/bashhelp.sh'
alias hmupdf='~/.bin/mupdfhelp.sh'
alias drop='~/.bin/drop.sh'
alias tnij='~/.bin/tnijpdf.sh'

# zmienne
muz=/home/piotr/Muzyka
pod=/home/piotr/Pobrane
dot=/home/piotr/.dotfiles
moc=/home/piotr/.moc
pob=/home/piotr/Pobrane
obr=/home/piotr/Obrazy
wid=/home/piotr/Wideo

# git
alias gts='git status'
alias push='git push'
alias pull='git pull'
alias gta='git add'
alias gtc='git commit -a -m'
