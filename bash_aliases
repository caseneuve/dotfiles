# ~/.dotfiles/bash_aliases
# Last update: 12.04.18, 23:48:06 @lenovo

########################
########################
###   BASH ALIASES   ###
########################
########################

#########################
### KOMENDY TERMINALA ###
#########################

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

##############
## FUNKCJE ###
##############

# wejdź do katalogu i wyświetl zawartość
cdls() { cd "$@" && ls; }

# utwórz katalog i wyświetl zawartość nadrzędnego katalogu sortując najpierw katalogi
mk()
{
    mkdir -p -- "$1" &&
        ls -a --group-directories-first
}

# utwórz katalog i wejdź do niego
mkc()
{
    mkdir -p -- "$1" &&
        cd -P -- "$1"
}

# mpv open playlist
mpvplaylist()
{
    if [ -f "playlist" ]; then
        mpv --playlist="playlist" &
    else
        if [ $# -eq 0 ]; then
            mpv &
        else
            mpv --playlist="$1"
        fi
    fi
}

#################
### POLECENIA ###
#################

alias sleep='systemctl suspend'
alias sle='systemctl suspend'
alias Reboot='systemctl reboot -i'
alias sbr='source ~/.bashrc'
alias nba='nano --nohelp ~/.bash_aliases'
alias nbr='nano --nohelp ~/.bashrc'
alias nco='nano --nohelp ~/.compton.conf'
alias PSyyu='sudo pacman -Syyu'
alias sp='sudo pacman -S'
alias spR='sudo pacman -Rs'
alias ya='yaourt --noconfirm'
alias nlog='date >> /home/piotr/.log-antergos; nano --nohelp /home/piotr/.log-antergos'
alias yta='youtube-dl --extract-audio --audio-format mp3'
alias yt=youtube-dl
alias nmt='nano ~/.muttrc'
alias ntm='nano ~/.config/termite/config'
alias ntx='nano ~/.tmux.conf'
alias ch7='chmod 750 $1'
alias mejk='make && sudo make install'

# emacsclient
alias cfg='emacsclient -nw /home/piotr/.dotfiles/i3/config'
alias eba='emacsclient -nw  ~/.bash_aliases'
alias ebr='emacsclient -nw  ~/.bashrc'
alias eco='emacsclient -nw  ~/.compton.conf'
alias elog='date >> /home/piotr/.log-antergos; emacsclient -nw  /home/piotr/.log-antergos'
alias emt='emacsclient -nw ~/.muttrc'
alias etm='emacsclient -nw ~/.config/termite/config'
alias etx='emacsclient -nw ~/.tmux.conf'
alias eno='emacsclient -nw /home/piotr/Dropbox/EMACS/notes.org'
alias ebib='emacsclient -nw /home/piotr/Dropbox/EMACS/bib-log.org'

################
### PROGRAMY ###
################

alias t=trans
alias tb='trans $1 -b'
alias tt=termite
alias ff=fzf
alias e="emacsclient -nw -c $1"
alias r=ranger
alias m="mocp -l"
alias ms="mocp -s"
alias mp="mocp -G"
alias mn="mocp -f"
alias mN="mocp -r"
alias mr="mocp -o r"
alias mq="mocp -q"
alias mS="mocp -S"
alias m3='i3-msg -q "workspace 8; exec --no-startup-id st -e mocp"'
alias f='feh -B black'
alias n='nano --nohelp'
alias nl='nano -l --nohelp'
alias qb=qutebrowser
alias qtb='i3-msg -q "workspace 2; exec --no-startup-id qutebrowser"'
alias qb='i3-msg -q "workspace 2; exec --no-startup-id qutebrowser"'
alias qp='i3-msg -q "workspace 7; exec --no-startup-id qutebrowser :command \":open -p\""'
alias v=mpv
alias mpva='mpv --no-video'
alias va='mpv --no-video'
alias Mpva='mpv --no-video --input-ipc-server=/tmp/mpvsocket'
alias Ma='mpv --no-video --input-ipc-server=/tmp/mpvsocket'
alias Mpvp="echo '{\"command\": [\"cycle\", \"pause\"]}' | socat - /tmp/mpvsocket &>/dev/null"
alias Mp="echo '{\"command\": [\"cycle\", \"pause\"]}' | socat - /tmp/mpvsocket &>/dev/null"
alias Mpause="echo '{\"command\": [\"cycle\", \"pause\"]}' | socat - /tmp/mpvsocket &>/dev/null"
#alias vl='mpv --playlist=/home/piotr/Wideo/playlist &'
#alias vp='mpv --playlist=playlist &'
alias vp=mpvplaylist
alias mpvp=mpvplaylist
#alias mpvp=mpvopenplaylist
alias c=calcurse
alias caa='i3-msg -q "exec --no-startup-id st -e calcurse"'
alias clc='clear; bc -q'
alias kal='cal -s --color'
alias hg=hangups 
alias mu=mupdf
alias mt='cd ~/Pobrane; mutt'
alias nf='clear; neofetch'

###################
### SYSTEM INFO ###
###################

alias bat='upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"'

###############
### SKRYPTY ###
###############

alias wall='/home/piotr/.dotfiles/bin/wall.sh'
alias walp='/home/piotr/.dotfiles/bin/walp.sh'
alias wallp='/home/piotr/.dotfiles/bin/walp.sh' 
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
alias pif='$home/.dotfiles/bin/ifpackage.sh'
alias sm='$home/.dotfiles/bin/sendmail.sh'
alias kbd='$home/.dotfiles/bin/kbd-help.sh'
alias update='/home/piotr/.dotfiles/bin/update.sh'
alias monitory='/home/piotr/.dotfiles/bin/monitoryL.sh'
alias monitL='/home/piotr/.dotfiles/bin/monitoryL.sh'
alias monitR='/home/piotr/.dotfiles/bin/monitoryR.sh'
alias monitory2='/home/piotr/.dotfiles/bin/monitory-duplicate.sh'
alias notes='/home/piotr/.dotfiles/bin/notes.sh'
alias nt='/home/piotr/.dotfiles/bin/notes.sh'
alias updt='/home/piotr/.dotfiles/bin/update-local.sh'

##############
#    DMENU   #
##############

alias emm='i3-msg -q "workspace 1; exec --no-startup-id emacs"'
alias cu='i3-msg -q "exec --no-startup-id $TERMINAL -e calcurse"'
alias dmo='i3-msg -q "workspace 8; exec --no-startup-id $TERMINAL -e mocp"'
alias rng='i3-msg -q "workspace 6; exec --no-startup-id $TERMINAL -e ranger"'
alias rrr='i3-msg -q "workspace 6; exec --no-startup-id $TERMINAL -e ranger"'
alias dmutt='i3-msg -q "workspace 10; exec --no-startup-id $TERMINAL -e neomutt"'
#alias dmt='i3-msg -q "workspace 10; exec --no-startup-id $TERMINAL -e neomutt"'
alias dmu='i3-msg -q "workspace 10; exec --no-startup-id $TERMINAL -e neomutt"'
alias neo='i3-msg -q "workspace 10; exec --no-startup-id $TERMINAL -e neomutt"'
alias nbb='i3-msg -q "exec --no-startup-id $TERMINAL -e newsboat"'
alias nb='i3-msg -q "workspace 10; exec --no-startup-id $TERMINAL -e newsboat"'

###############
### ZMIENNE ###
###############

home=/home/piotr
muz=/home/piotr/Muzyka
pod=/home/piotr/Pobrane
dot=/home/piotr/.dotfiles
moc=/home/piotr/.moc
pob=/home/piotr/Pobrane
obr=/home/piotr/Obrazy
wid=/home/piotr/Wideo

###########
### GIT ###
###########

alias gts='/home/piotr/.dotfiles/bin/gitstatus.sh'
alias push='/home/piotr/.dotfiles/bin/gitpush.sh'
alias pull='/home/piotr/.dotfiles/bin/gitpull.sh'
alias gta='git add'
alias gtc='git commit -m'

alias ggl='if [ -d /home/piotr/pcloud ]; then cd /home/piotr/pcloud; else echo "Na tym komputerze nie ma katalogu: ~/pcloud/"; fi'
alias gl='if [ -d /home/piotr/pcloud ]; then cd /home/piotr/pcloud; else echo "Na tym komputerze nie ma katalogu: ~/pcloud/"; fi'

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
alias gkk='cd /home/piotr/Książki'
alias gkK='cd /home/piotr/Kursy'
alias gku='cd /home/piotr/Kursy/Udemy-web-developer-bootcamp'
alias gke='cd /home/piotr/Kursy/Udemy-web-developer-bootcamp/Exercises'
alias gy='cd /home/piotr/Dokumenty'
alias gc='cd /home/piotr/.config'
alias gcc='cd /home/piotr/.config'
alias gcr='cd /home/piotr/.config/ranger'
alias gct='cd /home/piotr/.config/termite'
alias gcx='cd /home/piotr/.config/xfce4'
alias gcb='cd /home/piotr/.bak'
alias gcq='cd /home/piotr/.config/qutebrowser'
alias gC='cd /home/piotr/.calcurse'
alias gd='cd /home/piotr/.dotfiles'
alias gdd='cd /home/piotr/.dotfiles'
alias gdb='cd /home/piotr/.dotfiles/bin'
alias gdi='cd /home/piotr/.dotfiles/i3'
alias gdr='cd /home/piotr/.dotfiles/ranger'
alias gdc='cd /home/piotr/.dotfiles/calcurse'
alias gdB='cd /home/piotr/.dotfiles/Boot-ex'
alias gdq='cd /home/piotr/.dotfiles/qtbro'
alias gx='cd /home/piotr/Dropbox'
alias gxx='cd /home/piotr/Dropbox'
alias gxc='cd /home/piotr/Dropbox/config'
alias gxl='cd /home/piotr/Dropbox/linux'
alias gxp='cd /home/piotr/Dropbox/linux/pdf'
alias gxs='cd /home/piotr/Dropbox/!szkoła'
alias ge='cd /home/piotr/Dropbox/EMACS'
alias gee='cd /home/piotr/Dropbox/EMACS'
alias gs='cd /home/piotr/Dropbox/EMACS/szkoła'
alias geg='cd /home/piotr/.emacs.git'
alias ged='cd /home/piotr/.emacs.d'
alias gcm='cd /home/piotr/.mutt'
alias gdx='cd /home/piotr/.dotfiles/Boot-ex'
alias gM='cd /media'
alias gr='cd /'
alias gR='cd /root'
alias gg='cd /home/piotr/gitlab'
alias ggg='cd /home/piotr/gitlab'
alias ggl='cd /home/piotr/gitlab/liberal_artist_org'
alias gcs='cd /home/piotr/suckless/st'

# fast dirs end

