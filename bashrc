############################################
###    _               _                 ###
###   | |__   __ _ ___| |__  _ __ ___    ###
###   | '_ \ / _` / __| '_ \| '__/ __|   ###
###   | |_) | (_| \__ \ | | | | | (__    ###
###   |_.__/ \__,_|___/_| |_|_|  \___|   ###
###                                      ###
############################################

# Created:     26.06.18, 13:16    @lenovo
# Last update: 25.12.18, 19:10:22 @x200

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
export HISTIGNORE="klr:q:yayup:ls:sbr:history"

## >> COMMAND PROMPT
# >>> prompt colors
BLUE="$(tput setaf 4)"
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
MAGENTA="$(tput setaf 13)"
#PSGIT="$(tput setaf 197)"
PSGIT="$(tput setaf 2)"

# >>> command prompt func
__command_prompt () {
    code=$?
    if [[ $PWD == $HOME ]]; then
        DIR="~"
    else
        DIR="${PWD#$HOME/}"
    fi
    [[ $DIR =~ "Dropbox" ]] && DIR=${DIR/box\/Dropbox\//dp:}
    if [[ "$code" != 0 ]]; then
        COLOR=$RED
    else
        COLOR=$GREEN
    fi
    GTS=$(git status 2>/dev/null)
    GITB=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    case $GTS in
        *'use "git push"'*)
            GTS=" ✔ "
            GITCOL=$ORANGE ;; 
        *'nothing to commit'*)
            GTS=" ✔ "
            GITCOL=$BLUE ;; 
        *'not staged'*|*'Untracked'*|*'modified'*|*'to be committed'*|*'deleted')
            GTS=" ✗ "
            GITCOL=$RED ;;
        *) GTS= ;;
    esac

    if [[ -n $VIRTUAL_ENV ]]; then
        [[  $(echo "$PWD" | grep "${VIRTUAL_ENV##*/}") ]] && VENV="{venv:} " || VENV="{venv: ${VIRTUAL_ENV##*/}} "
    else
        VENV=
    fi
    
    if [[ -n $GTS || -n $VENV ]] ; then
        PS1="\[$MAGENTA\]$VENV\[$RESET\]\[$PSGIT\]$GITB\[$RESET\]\[$GITCOL\]$GTS\[$RESET\]\[$BOLD\]\[$WHITE\]$DIR\[$RESET\]\[$COLOR\]:\[$RESET\] "
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

## >> ENV VARIABLES:
# >>> path:
export PATH=$PATH:~/bin:~/scr:~/.cargo/bin
export LC_MESSAGES=C # let command line messages be in English
export BROWSER=/usr/bin/qutebrowser
export VISUAL=""
#export EDITOR='emacsclient -nw'
export EDITOR=emacsclient
export ALTERNATE_EDITOR=nano
export RANGER_LOAD_DEFAULT_RC=FALSE
LS_COLORS=$LS_COLORS:'di=1;34:' ; export LS_COLORS
# set grep match color to bold, blue (default red bold)
export GREP_COLORS="mt=01;34"

## >> LESS COLORS for MAN 
export LESS=-R
export LESS_TERMCAP_so=$'\E[01;37;31m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;33m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESS_TERMCAP_mb=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;34m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink

## >> VARIOUS:
# >>>  mutt background fix
COLORFGBG="default;default"

# >>  - bc calc
export BC_ENV_ARGS=$HOME/.bc

TERM=xterm-256color
export TERMINAL=st

## >> SOURCE:
# >>> source aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# >>> source fzf
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

