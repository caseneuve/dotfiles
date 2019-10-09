####################################################################
###    _               _              _ _                        ###
###   | |__   __ _ ___| |__      __ _| (_) __ _ ___  ___  ___    ###
###   | '_ \ / _` / __| '_ \    / _` | | |/ _` / __|/ _ \/ __|   ###
###   | |_) | (_| \__ \ | | |  | (_| | | | (_| \__ \  __/\__ \   ###
###   |_.__/ \__,_|___/_| |_|   \__,_|_|_|\__,_|___/\___||___/   ###
###                                                              ###
####################################################################

# Doc: # ~/.dotfiles/bash_aliases
# Last update: 2019-09-22, 15:17:05 @x200

#* VARIABLES:
MYTERM='st -c term'

#* KOMENDY TERMINALA 
alias mkd=mkdir
alias ls='ls -hN --color=auto --group-directories-first'
alias q=exit
#alias cl=clear
alias cls=clear
alias klr=clear
alias la='ls -a1'
alias ll='ls -l'
alias cdl='cd $1;ls'
alias 'cd.'='cd ..'
alias '..'='cd ..'
alias 'cd..'='cd ../..' 
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
alias cl='i3-msg -q splith; cd $PWD && $MYTERM &'
alias clo='i3-msg -q splitv; cd $PWD && $MYTERM &'

#* FUNKCJE
# >> F: is app running
app_running_p(){
    ps aux | grep "$1" | grep -v grep
}
alias psaux=app_running_p

kill_running_app(){
    app_running_p "$1" | awk '{print $2}' | xargs kill -9
}
alias psauk=kill_running_app

# >> F: copy path
copy_path(){ echo $PWD/$1 | xclip -selection clipboard; } 
alias cpa=copy_path

# >> F: find file
find_file(){ find $1 -type f | grep $2; }
alias fif=find_file

# >> F: alias add
alias_add(){ echo "alias $1='$2'" >> ~/.bash_aliases; }
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


#* POLECENIA 
alias sle='systemctl suspend'
alias Reboot='systemctl reboot -i'
alias sbr='source ~/.bashrc'
alias sba='source ~/.bash_aliases'
alias nba='nano --nohelp ~/.bash_aliases'
alias nbr='nano --nohelp ~/.bashrc'
alias nco='nano --nohelp ~/.compton.conf'
alias PSyyu='sudo pacman -Syyu && pkill -RTMIN+12 i3blocks'
alias sp='sudo pacman -S'
alias spR='sudo pacman -Rs'
#alias yayup=~/.dotfiles/bin/yayup.sh
alias yayup='yay -Syu && pkill -RTMIN+12 i3blocks'
alias yaya='yay -Syua'
alias yta='youtube-dl --add-metadata -ixc --audio-format mp3' 
alias yt='youtube-dl --add-metadata -ic'
alias ch7='chmod 750 $1'
alias mejk='make && sudo make install'

#* PROGRAMY
alias hugop='rm -fr public && hugo'
alias dps='dropbox-cli status'
alias gromit=gromit-mpx
alias ccat="highlight --out-format=ansi"
alias i3g=i3get
alias i3m=i3move
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

#* SYSTEM INFO 
alias bat='upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"'

#* SKRYPTY
alias wikd=/home/piotr/.dotfiles/other/wiki-date.sh
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
alias notes='/home/piotr/.dotfiles/bin/notes.sh'
alias nt='/home/piotr/.dotfiles/bin/notes.sh'
alias updt='/home/piotr/.dotfiles/bin/update-local.sh'
alias pdfs='/home/piotr/.dotfiles/bin/mupdf-cache.sh'
alias pdfr='/home/piotr/.dotfiles/bin/mupdf-restore-session.sh'
alias pdfrs='/home/piotr/.dotfiles/bin/mupdf_restore.sh'

#* DMENU (deprecated...)
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

#* ZMIENNE 
home=/home/piotr
muz=/home/piotr/muz
pob=/home/piotr/dwl
dot=/home/piotr/.dotfiles
obr=/home/piotr/obr
wid=/home/piotr/wid
att=/home/piotr/dwl/att

alias home='cd /home/piotr'
alias muz='cd /home/piotr/muz'
alias pob='cd /home/piotr/dwl'
alias dot='cd /home/piotr/.dotfiles'
alias obr='cd /home/piotr/obr'
alias wid='cd /home/piotr/wid'
alias att='cd /home/piotr/dwl/att'

#* GIT 
alias gito='git checkout'
alias gts='/home/piotr/.dotfiles/bin/gitstatus.sh'
alias push='/home/piotr/.dotfiles/bin/gitpush.sh'
alias pull='/home/piotr/.dotfiles/bin/gitpull.sh'
alias gta='git add'
alias gtc='git commit -m'
alias gits='git status'
alias gita='git add'
alias gitl='git pull'
alias gitp='git push'
alias gitc='git commit -m'
alias gitb='git branch'

#* PCCLOUD
alias ggl='if [ -d /home/piotr/pcloud ]; then cd /home/piotr/pcloud; else echo "Na tym komputerze nie ma katalogu: ~/pcloud/"; fi'
alias gl='if [ -d /home/piotr/pcloud ]; then cd /home/piotr/pcloud; else echo "Na tym komputerze nie ma katalogu: ~/pcloud/"; fi'

#* GREP
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

#* FAST DIRS
# >> fast dirs start

alias gB='cd ~/biu'
alias gC='cd ~/.config'
alias gD='cd ~/box/Dropbox/Dokumenty'
alias gaa='cd ~/dwl'
alias gag='cd ~/dwl/att'
alias gcf='cd ~/.config/fish'
alias gcl='cd ~/.config/lf'
alias gcm='cd ~/.config/neomutt'
alias gcn='cd ~/.newsboat'
alias gcq='cd ~/.config/qutebrowser'
alias gcr='cd ~/.config/ranger'
alias gct='cd ~/.config/termite'
alias gcx='cd ~/.config/xfce4'
alias gdb='cd ~/.dotfiles/bin'
alias gdd='cd ~/.dotfiles'
alias gdf='cd ~/.dotfiles/fish'
alias gdi='cd ~/.dotfiles/i3'
alias gdq='cd ~/.dotfiles/qtbro'
alias gdr='cd ~/.dotfiles/ranger'
alias ged='cd ~/.emacs.d'
alias geg='cd ~/git/hub/emacs'
alias geh='cd ~/git/hub/heder'
alias ggg='cd ~/git'
alias ggh='cd ~/git/hub'
alias ggl='cd ~/git/lab'
alias ggo='cd ~/go'
alias ggp='cd ~/git/lab/py-exercises'
alias ggs='cd ~/git/hub/st'
alias gh='cd ~'
alias gm='cd ~/muz'
alias gob='cd ~/obr'
alias goo='cd ~/org'
alias gp='cd ~/pdf'
alias gsc='cd ~/scr'
alias gwe='cd ~/web'
alias gws='cd ~/web/schole'
alias gwt='cd ~/web/test'
alias gww='cd ~/wid'
alias gx@='cd ~/box/Dropbox/Web'
alias gxS='cd ~/box/Dropbox/Szkoła/19-20'
alias gxb='cd ~/box/Dropbox/Biurko'
alias gxc='cd ~/box/Dropbox/.Config'
alias gxd='cd ~/box/Dropbox/Dokumenty'
alias gxj='cd ~/box/Dropbox/Joby'
alias gxp='cd ~/box/Dropbox/Programowanie'
alias gxr='cd ~/box/Dropbox/Dokumenty/Projekty'
alias gxs='cd ~/box/Dropbox/Szkoła'
alias gxw='cd ~/box/Dropbox/Wiki'
alias gxx='cd ~/box/Dropbox'

# >> fast dirs end

#* aliased added by `alias_add' func:
alias p1='ping 1.1.1.1'

