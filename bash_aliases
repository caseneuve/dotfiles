####################################################################
###    _               _              _ _                        ###
###   | |__   __ _ ___| |__      __ _| (_) __ _ ___  ___  ___    ###
###   | '_ \ / _` / __| '_ \    / _` | | |/ _` / __|/ _ \/ __|   ###
###   | |_) | (_| \__ \ | | |  | (_| | | | (_| \__ \  __/\__ \   ###
###   |_.__/ \__,_|___/_| |_|   \__,_|_|_|\__,_|___/\___||___/   ###
###                                                              ###
####################################################################

# Doc: # ~/.dotfiles/bash_aliases
# Last update: 15.08.18, 17:58:53 @x200

## >> KOMENDY TERMINALA 
alias mkd=mkdir
alias ls='ls --color=auto'
alias q=exit
alias cl=clear
alias cls=clear
alias klr=clear
alias la='ls -a1'
alias ll='ls -l'
alias cdl='cd $1;ls'
alias 'cd.'='cd ..'
alias '..'='cd ..'
alias lg='ls --group-directories-first'
alias lg1='ls -1 --group-directories-first'
alias ls1='ls -1'
alias lag='ls -a --group-directories-first'
alias lal='ls -al --group-directories-first'
alias lal1='ls -al --group-directories-first'
alias la1='ls -a1 --group-directories-first'
alias kl=pkill
alias grep='grep --color=auto'
alias thg='tmux new-window -n "hg" "hangups"'
alias xclip='xclip -selection c'
alias cpwd='pwd | xclip -selection c'
alias treeno="tree | sed 's/-> [-/a-zA-Z0-9\.\_ ]*//g'"

## >> FUNKCJE 
# >> F: find file
find_file(){
    find $1 -type f | grep $2
}

alias fif=find_file

# >> F: alias add
alias_add(){
    echo "alias $1='$2'" >> ~/.bash_aliases
}

alias aa=alias_add

# >> F: wyświetl kolory
colors(){
    clear
    for C in {0..255}; do
        tput setab $C
        echo -n "$C "
    done
    tput sgr0
    echo -e "\n"
}

# >> F: wejdź do katalogu i wyświetl zawartość
cdls() { cd "$@" && ls; }

# >> F: utwórz katalog i wyświetl zawartość nadrzędnego katalogu sortując najpierw katalogi
mk()
{
    mkdir -p -- "$1" &&
        ls -a --group-directories-first
}

# >> F: utwórz katalog i wejdź do niego
mkc()
{
    mkdir -p -- "$1" &&
        cd -P -- "$1"
}

# >> F: mpv open playlist
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

# >> F: cmd help FIXME: poprawić czitsity
cmdhelp()
{
    curl cheat.sh/"$1"
}

# >> F: uses William Whitaker Words (online) to translate a word given as the function argument 
translate_ww()
{
    clear;
    echo -e "$(tput bold)### William Whitaker Words: ###$(tput sgr0)\n"
    curl -s http://archives.nd.edu/cgi-bin/wordz.pl?keyword=/$1 | awk '! /</' | GREP_COLOR="0;34" egrep --color=always ".*XXX.*|$" | GREP_COLOR="0;92" egrep --color=always "$1|$" | GREP_COLOR="0;93" egrep --color=always ".*;.*|$"
}

# >> F: mupdf restore session
mupdf_restore()
{
    sed '/^$/d; /#/d' $1 | while read line ;
    do
        [[ -f $line ]] && mupdf "$line" > /dev/null 2>&1 &
    done 
}

# >> F: calcurse search
calcurse_search()
{
    calcurse -s01/01$(date +/%Y) -d365 --search=$1 --format-apt='- %m (%S-%E)\n' --format-recur-apt='- %m (%S-%E)\n'
}

alias cals=calcurse_search

calcurse_search_future()
{
    calcurse -d365 --search=$1 --format-apt='- %m (%S-%E)\n' --format-recur-apt='- %m (%S-%E)\n'
}

alias calS=calcurse_search_future


## >> POLECENIA 
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
alias yaup='yaourt --noconfirm -Syu --aur'
alias nlog='date >> /home/piotr/.log-antergos; nano --nohelp /home/piotr/.log-antergos'
alias yta='youtube-dl --extract-audio --audio-format mp3'
alias yt=youtube-dl
alias nmt='nano ~/.muttrc'
alias ntm='nano ~/.config/termite/config'
alias ntx='nano ~/.tmux.conf'
alias ch7='chmod 750 $1'
alias mejk='make && sudo make install'

## >> EMACSCLIENT
alias cfg='emacsclient -nw /home/piotr/.dotfiles/i3/config'
alias eba='emacsclient -nw  ~/.bash_aliases'
alias ebr='emacsclient -nw  ~/.bashrc'
alias eco='emacsclient -nw  ~/.compton.conf'
alias elog='date >> /home/piotr/.log-antergos; emacsclient -nw  /home/piotr/.log-antergos'
alias emt='emacsclient -nw ~/.muttrc'
alias etm='emacsclient -nw ~/.config/termite/config'
alias etx='emacsclient -nw ~/.tmux.conf'
alias ebib='emacsclient -nw /home/piotr/Dropbox/EMACS/bib-log.org'
alias egtd='emacsclient -nw /home/piotr/org/gtd/gtd.org'
alias eno='emacsclient -nw /home/piotr/org/gtd/gtd.org'

## >> PROGRAMY
alias pdfg='pdfgrep'
alias yv='youtube-viewer'
alias wm=wmctrl
alias ipy=ipython
alias t=trans
alias te='trans -t en'
alias tl=translate_ww
alias tll='trans -s lat'
alias tb='trans $1 -b'
alias tt=termite
alias ff=fzf
alias e="emacsclient -nw -c"
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
alias calt='echo -e "TODO:\n$(calcurse -t --format-todo "(%p) %m\t>> %N" | tail -n +2 | sed '/^\s*$/d')"'
alias kal='cal --color=always -n 3'
alias hg=hangups 
alias mu=mupdf
alias mt='cd ~/Pobrane; mutt'
alias nf='clear; neofetch'
alias h=cmdhelp

## >> SYSTEM INFO 
alias bat='upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"'

## >> SKRYPTY 
alias check=checkupdates # from pacman-contrib
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
alias pdfs='/home/piotr/.dotfiles/bin/mupdf-cache.sh'
alias pdfr='/home/piotr/.dotfiles/bin/mupdf-restore-session.sh'
alias pdfrs='/home/piotr/.dotfiles/bin/mupdf_restore.sh'

## >> DMENU (deprecated...)
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
alias rss='i3-msg -q "workspace 10; exec --no-startup-id $TERMINAL -e newsboat"'
alias news='i3-msg -q "workspace 10; exec --no-startup-id $TERMINAL -e newsboat"'

## >> ZMIENNE 
home=/home/piotr
muz=/home/piotr/Muzyka
pod=/home/piotr/Pobrane
dot=/home/piotr/.dotfiles
moc=/home/piotr/.moc
pob=/home/piotr/Pobrane
obr=/home/piotr/Obrazy
wid=/home/piotr/Wideo

## >> GIT 
alias gts='/home/piotr/.dotfiles/bin/gitstatus.sh'
alias push='/home/piotr/.dotfiles/bin/gitpush.sh'
alias pull='/home/piotr/.dotfiles/bin/gitpull.sh'
alias gta='git add'
alias gtc='git commit -m'
alias ggl='if [ -d /home/piotr/pcloud ]; then cd /home/piotr/pcloud; else echo "Na tym komputerze nie ma katalogu: ~/pcloud/"; fi'
alias gl='if [ -d /home/piotr/pcloud ]; then cd /home/piotr/pcloud; else echo "Na tym komputerze nie ma katalogu: ~/pcloud/"; fi'

## >> GREP
mal=~/Dropbox/config/.mutt_aliases
malias_func(){
    if [ "$(cat $mal | grep -i "$1")" ]; then
        echo
        echo $(cat $mal | grep -i "$1" | sed 's/alias//' | awk -v on="$(tput setab 4)" -v off="$(tput sgr0)" '{ $1=on $1 off }; 1')
        echo
    else
        echo "No alias found in $mal"
    fi
    }
alias malias=malias_func
alias mal=malias_func

# fast dirs start

alias gh='cd /home/piotr'
alias ga='cd /home/piotr/dwl'
alias gaa='cd /home/piotr/dwl'
alias gag='cd /home/piotr/dwl/att'
alias go='cd /home/piotr/obr'
alias gob='cd /home/piotr/obr'
alias goo='cd /home/piotr/org'
alias gol='cd /home/piotr/org/log'
alias gog='cd /home/piotr/org/gtd'
alias gss='cd /home/piotr/scr'
alias gw='cd /home/piotr/wid'
alias gm='cd /home/piotr/muz'
alias gp='cd /home/piotr/pdf'
alias gB='cd /home/piotr/biu'
alias gb='cd /home/piotr/bin'
alias gbi='cd /home/piotr/bin'
alias gS='cd /home/piotr/szk'
alias gy='cd /home/piotr/dox'
alias gc='cd /home/piotr/.config'
alias gC='cd /home/piotr/.config'
alias gcr='cd /home/piotr/.config/ranger'
alias gct='cd /home/piotr/.config/termite'
alias gcx='cd /home/piotr/.config/xfce4'
alias gcb='cd /home/piotr/.bak'
alias gcq='cd /home/piotr/.config/qutebrowser'
alias gcn='cd /home/piotr/.newsboat'
alias gcm='cd /home/piotr/.mutt'
alias gcs='cd /home/piotr/git/hub/suckless/st'
alias gd='cd /home/piotr/.dotfiles'
alias gdd='cd /home/piotr/.dotfiles'
alias gdb='cd /home/piotr/.dotfiles/bin'
alias gdi='cd /home/piotr/.dotfiles/i3'
alias gdr='cd /home/piotr/.dotfiles/ranger'
alias gdc='cd /home/piotr/.dotfiles/calcurse'
alias gdq='cd /home/piotr/.dotfiles/qtbro'
alias gdo='cd /home/piotr/dox'
alias gx='cd /home/piotr/box/Dropbox'
alias gxx='cd /home/piotr/box/Dropbox'
alias gxc='cd /home/piotr/box/Dropbox/.Config'
alias gxs='cd /home/piotr/box/Dropbox/Szkoła'
alias gD='cd /home/piotr/box/Dropbox/Dokumenty'
alias geg='cd /home/piotr/.emacs.git'
alias ged='cd /home/piotr/.emacs.d'
alias gM='cd /media'
alias gr='cd /'
alias gR='cd /root'
alias gg='cd /home/piotr/git/lab'
alias ggg='cd /home/piotr/git/lab'

# fast dirs end

# >> aliased added by `alias_add' func:
alias p1='ping 1.1.1.1'

