# ~/.bashrc
# Last update: 25.06.18, 23:31:56 @toshiba

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# PS1='[\u@\h \W]\$ '

# PS1='\[\e[33m\][\[\e[36m\]\A \[\e[32m\]\w\[\e[m\e[33m\]]\[\e[33m\]$\[\e[0m\] '
#    | orange |[| cyan   |tim| green  | dir| pink  |  git branch                                    | orange      |]$| reset |

# PS1='\[\e[33m\][\[\e[1;36m\]\A \[\e[32m\]\w \[\e[31m\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\e[m\e[33m\]]$\[\e[0m\] '

# wersja z żółtym tłem
PS1='\e[1;33m\] \e[34m\]\e[43m\]\A \[\e[32m\]\w \[\e[31m\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\e[m\e[1;33m\] $\[\e[0m\] '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

shopt -s autocd

# VARIABLES:

# BROWSER=/usr/bin/firefox
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
#TERMINAL=xfce4-terminal
export TERMINAL=st

# fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

