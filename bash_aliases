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

# fast dirs
alias gc='cd ~/.config;ls -a'
alias gd='cd ~/Pobrane;ls -a'
alias gh='cd ~'
alias home=$HOME
alias cdD='cd ~/.dotfiles;ls -a'

# funkcje
cdls() { cd "$@" && ls; }

# polecenia
alias sbr='source ~/.bashrc'
alias cfg='emacsclient ~/.i3/config'
alias nba='nano ~/.bash_aliases'
alias nbr='nano ~/.bashrc'
alias mpva='mpv --no-video'
alias PSyyu='sudo pacman -Syyu'
alias sp='sudo pacman -S'
alias ya=yaourt
alias nlog='date >> ~/.log-antergos; nano ~/.log-antergos'

# programy 
alias em=emacsclient
alias r=ranger
alias m=mocp 
alias f=feh
alias n=nano
alias qb=qutebrowser
alias v=mpv 
alias c=calcurse
alias clc=gcalccmd
alias kal='cal -s --color'
alias hg=hangups 
alias mp=mupdf

# system info / akcje
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|percentage"'

# skrypty
alias wall='~/.bin/wall.sh'
# alias kl='~/.bin/kill.sh'
alias kl=pkill
alias bhelp='~/.bin/bashhelp.sh'
alias hbash='~/.bin/bashhelp.sh'
alias hmupdf='~/.bin/mupdfhelp.sh'
