#####################
###   MY BASHRC   ### 
#####################

# Created:     26.06.18, 13:16    @lenovo
# Last update: 26.06.18, 13:27:02 @lenovo

# Doc:
# note: escape chars for bash prompt have been put into format string, because the string has to be in single quote (not double) to make evaluation of git command inside it possible
# note: lack of escape characters results in strange behaviour, e.g. not going to next line with input etc.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# COMMAND PROMPT
# → colors
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

# → string format
export PS1='\[${BLUEBG}\]\[${WHITE}\]\A \[${GREENBG}\]\[${WHITE}\] \w \[${REDBG}\]\[${WHIFG}\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[${RESET}\] \[${ORANGE}\]\[${BOLD}\]\$\[${RESET}\] '

# → old
#PS1='[\u@\h \W]\$ '
#PS1='\[\e[33m\][\[\e[36m\]\A \[\e[32m\]\w\[\e[m\e[33m\]]\[\e[33m\]$\[\e[0m\] '
#PS1='\[\e[33m\][\[\e[1;36m\]\A \[\e[32m\]\w \[\e[31m\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\e[m\e[33m\]]$\[\e[0m\] '
#PS1='\e[33m\] \e[34m\]\e[1;43m\]\A \[\e[32m\]\w \[\e[31m\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\e[m\e[33m\] $\[\e[0m\]\e[m '

shopt -s autocd

# VARIABLES:
export BROWSER=/usr/bin/qutebrowser
export VISUAL=""
export EDITOR='emacsclient -nw'
export ALTERNATE_EDITOR="nano"
export PATH=$PATH:~/.bin
export RANGER_LOAD_DEFAULT_RC=FALSE
# export TERM=xterm-xfree86

# mutt background fix
COLORFGBG="default;default"

# bc calc
export BC_ENV_ARGS=$HOME/.bc

TERM=xterm-256color
export TERMINAL=st

# SOURCE:
# → aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# → fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

