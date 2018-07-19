############################################
###    _               _                 ###
###   | |__   __ _ ___| |__  _ __ ___    ###
###   | '_ \ / _` / __| '_ \| '__/ __|   ###
###   | |_) | (_| \__ \ | | | | | (__    ###
###   |_.__/ \__,_|___/_| |_|_|  \___|   ###
###                                      ###
############################################

# Created:     26.06.18, 13:16    @lenovo
# Last update: 19.07.18, 13:28:02 @x200

# >> Doc:
# note: escape chars for bash prompt have been put into format string, because the string has to be in single quote (not double) to make evaluation of git command inside it possible
# note: lack of escape characters results in strange behaviour, e.g. not going to next line with input etc.

# >> If not running interactively, don't do anything
[[ $- != *i* ]] && return

# >> COMMAND PROMPT
# >> command prompt: colors
BLUE="$(tput setaf 4)"
BLUEBG="$(tput setab 4)"
GREEN="$(tput setaf 2)"
GREENBG="$(tput setab 2)"
ORANGE="$(tput setaf 3)"
BRORANGE="$(tput setaf 11)"
ORANGEBG="$(tput setab 3)"
RED="$(tput setaf 9)"
REDBG="$(tput setab 9)"
WHITE="$(tput setaf 15)"
WHITEBG="$(tput setab 15)"
BOLD="$(tput bold)"
RESET="$(tput sgr0)"
BLACK="$(tput setaf 8)"
MAGENTA="$(tput setaf 13)"

# >> command prompt: helper func
exitstatus()
{
    if [[ $? == 0 ]]; then
        echo $BLUE
    else
        echo $RED
    fi
}

# >> command prompt: string format
export PS1='\[$(exitstatus)\]\# \[$GREEN\]\w \[$RED\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[$RESET\] \[$ORANGE\]\$\[$RESET\] '
export PS2="\[$ORANGE\]> \[$RESET\]"
shopt -s autocd

# >> VARIABLES:
export BROWSER=/usr/bin/qutebrowser
export VISUAL=""
export EDITOR='emacsclient -nw'
export ALTERNATE_EDITOR="nano"
export PATH=$PATH:~/bin:~/scr
export RANGER_LOAD_DEFAULT_RC=FALSE
# export TERM=xterm-xfree86

# >> mutt background fix
COLORFGBG="default;default"

# >> bc calc
export BC_ENV_ARGS=$HOME/.bc

TERM=xterm-256color
export TERMINAL=st

# >> SOURCE:
# >> source: aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# >> source: finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

