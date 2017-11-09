#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# PS1='[\u@\h \W]\$ '
PS1='\[\e[33m\][\[\e[36m\]\A \[\e[32m\]\w\[\e[m\e[33m\]]\[\e[33m\]$\[\e[0m\] '

# >>> BEGIN ADDED BY CNCHI INSTALLER
BROWSER=/usr/bin/firefox
# EDITOR=/usr/bin/nano
# <<< END ADDED BY CNCHI INSTALLER

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PATH=$PATH:~/.bin
export RANGER_LOAD_DEFAULT_RC=FALSE
# export TERM=xterm-xfree86

shopt -s autocd
