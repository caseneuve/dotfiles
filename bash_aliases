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
alias gc='cd /home/piotr/.config;ls -a'
alias gd='cd /home/piotr/Pobrane;ls -a'
alias gh='cd ~; ls -a --group-directories-first'
alias home='cd /home/piotr; ls -a --group-directories-first'
alias cdD='cd /home/piotr/.dotfiles;ls -a'
alias cdO='cd /home/piotr/Obrazy;ls -a'
alias cdC='cd /home/piotr/.config;ls -a'
alias cdDr='cd /home/piotr/Dropbox;ls -a'
alias cdM='cd /home/piotr/Muzyka;ls -a'
alias cdW='cd /home/piotr/Wideo;ls -a'
alias cdP='cd /home/piotr/pdf;ls -a'
alias cdA='cd /home/piotr/Pobrane;ls -a'
alias cdC='cd /home/piotr/.config;ls -a'
alias cdS='cd /home/piotr/Szkoła;ls -a'
alias cdB='cd /home/piotr/.bin; ls -a'
alias cdH='cd /home/piotr/.help; ls -a'
alias cdE='cd /home/piotr/Dropbox/EMACS; ls -a --group-directories-first'
alias cdd='cd /home/piotr/Dropbox; ls -a --group-directories-first'
alias cdk='cd /home/piotr/Dokumenty; ls -a --group-directories-first'

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
alias cfg='emacsclient /home/piotr/.i3/config'
alias nba='nano --nohelp ~/.bash_aliases'
alias nbr='nano --nohelp ~/.bashrc'
alias nco='nano --nohelp ~/.compton.conf'
alias mpva='mpv --no-video'
alias PSyyu='sudo pacman -Syyu'
alias sp='sudo pacman -S'
alias ya=yaourt
alias nlog='date >> /home/piotr/.log-antergos; nano --nohelp /home/piotr/.log-antergos'

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
alias wall='/home/piotr/.bin/wall.sh'
alias bhelp='/home/piotr/.bin/bashhelp.sh'
alias hbash='/home/piotr/.bin/bashhelp.sh'
alias hmupdf='/home/piotr/.bin/mupdfhelp.sh'
alias drop='/home/piotr/.bin/drop.sh'
alias tnij='/home/piotr/.bin/tnijpdf.sh'

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
