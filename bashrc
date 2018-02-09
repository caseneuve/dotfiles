#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# PS1='[\u@\h \W]\$ '
# PS1='\[\e[33m\][\[\e[36m\]\A \[\e[32m\]\w\[\e[m\e[33m\]]\[\e[33m\]$\[\e[0m\] '
#    | orange |[| cyan   |tim| green  | dir| pink  |  git branch                                    | orange      |]$| reset |
PS1='\[\e[33m\][\[\e[1;36m\]\A \[\e[32m\]\w \[\e[31m\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\e[m\e[33m\]]$\[\e[0m\] '

BROWSER=/usr/bin/firefox
# EDITOR=/usr/bin/nano

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PATH=$PATH:~/.bin
export RANGER_LOAD_DEFAULT_RC=FALSE
# export TERM=xterm-xfree86

shopt -s autocd

# mutt background fix
COLORFGBG="default;default"

# bc calc
export BC_ENV_ARGS=$HOME/.bc

neofetch

