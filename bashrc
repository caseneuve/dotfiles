############################################
###    _               _                 ###
###   | |__   __ _ ___| |__  _ __ ___    ###
###   | '_ \ / _` / __| '_ \| '__/ __|   ###
###   | |_) | (_| \__ \ | | | | | (__    ###
###   |_.__/ \__,_|___/_| |_|_|  \___|   ###
###                                      ###
############################################

# Created:     26.06.18, 13:16    @lenovo
# Last update: 02.11.18, 18:31:49 @x200

## >> DOC:
# note: escape chars for bash prompt have been put into format string, because the string has to be in single quote (not double) to make evaluation of git command inside it possible
# note: lack of escape characters results in strange behaviour, e.g. not going to next line with input etc.

## >> PRELIM:
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# >>> disable C-s, C-q
stty -ixon

## >> HISTORY
export HISTCONTROL=ignoreboth:erasedups

## >> COMMAND PROMPT
# >>> prompt colors
#BLUE="$(tput setaf 4)"
#BLUEBG="$(tput setab 4)"
GREEN="$(tput setaf 2)"
#GREENBG="$(tput setab 2)"
ORANGE="$(tput setaf 3)"
#BRORANGE="$(tput setaf 11)"
#ORANGEBG="$(tput setab 3)"
RED="$(tput setaf 9)"
#REDBG="$(tput setab 9)"
WHITE="$(tput setaf 15)"
#WHITEBG="$(tput setab 15)"
BOLD="$(tput bold)"
RESET="$(tput sgr0)"
#BLACK="$(tput setaf 8)"
#MAGENTA="$(tput setaf 13)"
PSGIT="$(tput setaf 197)"

# >>> command prompt func
__command_prompt () {
    code=$?
    if [[ $PWD == $HOME ]]; then
        DIR="~"
    else
        DIR="${PWD#$HOME/}"
    fi
    if [[ "$code" != 0 ]]; then
        COLOR=$RED
    else
        COLOR=$GREEN
    fi
    GTS=$(git status 2>/dev/null)
    GITB=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    case $GTS in
        *'use "git push"'*)
            GTS="✔"
            GITCOL=$ORANGE ;; 
        *'nothing to commit'*)
            GTS="✔"
            GITCOL=$GREEN ;; 
        *'not staged'*|*'Untracked'*|*'modified'*|*'to be committed'*|*'deleted')
            GTS="✗"
            GITCOL=$ORANGE ;;
        *) GTS= ;;
    esac
    if [[ -n $GTS ]]; then
        PS1="\[$PSGIT\]$GITB\[$RESET\] \[$GITCOL\]$GTS\[$RESET\] \[$BOLD\]\[$WHITE\]$DIR\[$RESET\]\[$COLOR\]:\[$RESET\] "
    else
        PS1="\[$BOLD\]\[$WHITE\]$DIR\[$RESET\]\[$BOLD\]\[$COLOR\]:\[$RESET\] "
    fi
}

# >>> prompt string format
if [[ $(tty) =~ "/dev/tty" ]]; then
    export PS1='\[$RED\]\u\[$RESET\]@\h \[$BOLD\]\[$BLUE\]\w\[$RESET\] \$ '
else
    export PROMPT_COMMAND='__command_prompt; history -a; history -n'
    export PS2='\[$GREEN\]… \[$RESET\]'
fi

# >> auto cd
shopt -s autocd

# >> bind TAB to autocomplete
bind TAB:menu-complete

## >> VARIABLES:
export LC_MESSAGES=C # let command line messages be in English
export BROWSER=/usr/bin/qutebrowser
export VISUAL=""
export EDITOR='emacsclient -nw'
export ALTERNATE_EDITOR="nano"
export PATH=$PATH:~/bin:~/scr:~/.cargo
export RANGER_LOAD_DEFAULT_RC=FALSE

## >> VARIOUS:
# >>>  mutt background fix
COLORFGBG="default;default"

# >>  - bc calc
export BC_ENV_ARGS=$HOME/.bc

TERM=xterm-256color
export TERMINAL=st

# >> SOURCE:
# >>  - source aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# >>  - source finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# >> AKCJE / FUNKCJE
# >> dynamic terminal title (not in tmux!)
function automatic_title {
    #[[ -n "$TMUX" ]] || trap 'echo -ne "\033]0;$BASH_COMMAND ($(date +%H:%M))\007"' DEBUG
    #[[ -n "$TMUX" ]] || trap 'echo -ne "\033]0;$PWD ($(date +%H:%M))\007"' DEBUG
    # https://stackoverflow.com/a/7110386/9536161
    [[ -n "$TMUX" ]] ||  trap 'echo -ne "\033]2;$(history 1 | sed "s/^[ ]*[0-9]*[ ]*//g") ($(date +%H:%M))\007"' DEBUG
}

automatic_title

