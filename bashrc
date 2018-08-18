############################################
###    _               _                 ###
###   | |__   __ _ ___| |__  _ __ ___    ###
###   | '_ \ / _` / __| '_ \| '__/ __|   ###
###   | |_) | (_| \__ \ | | | | | (__    ###
###   |_.__/ \__,_|___/_| |_|_|  \___|   ###
###                                      ###
############################################

# Created:     26.06.18, 13:16    @lenovo
# Last update: 18.08.18, 19:32:57 @x200

# >> DOC:
# note: escape chars for bash prompt have been put into format string, because the string has to be in single quote (not double) to make evaluation of git command inside it possible
# note: lack of escape characters results in strange behaviour, e.g. not going to next line with input etc.

# >> PRELIM:
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# >> COMMAND PROMPT
# >>  - prompt colors
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
# >>  - ps colors
PSDIR="$(tput setaf 33)"
PSGIT="$(tput setaf 197)"

# >>  - prompt helper funcs
# >>    + exitstatus
exitstatus()
{
    if [[ $? == 0 ]]; then
        echo $BLUE
    else
        echo $RED
    fi
}

exitstatus2()
{
    [[ ! $? == 0 ]] && echo $RED || echo "$(tput setaf 240)" 
}

# >>    + vc_check (off)
# vc_check()
# {
#     GTS=$(git status 2>/dev/null) # wywala błąd fatal: not a git repository (or any of the parent directories): .git
#     GITB=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
#     OK=" ok"
#     NIE="$RED?$RESET"
#     [[ $(echo $GTS | grep fatal) ]] && exit
#     [[ $(echo $GTS | grep "nothing to commit") ]] && printf "%s %s" $GITB $OK || printf "%s" $NIE
# }

# >>    + print_pre_prompt
print_pre_prompt ()
{
    PS1L=$PWD
    [[ $PS1L/ = "$HOME"/* ]] && PS1L=\~${PS1L#$HOME}
    GTS=$(git status 2>/dev/null)
    GITB=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    GITB=$BOLD$PSGIT$GITB$RESET
    case $GTS in
        *'nothing to commit'*) GTS=$GREEN$(echo -e '\u2714 ')$RESET;; 
        *'not staged'*|*'Untracked'*|*'modified'*) GTS=$ORANGE$(echo -e '\u2717 ')$RESET;;
        *) GTS= ;;
    esac
    PS1R="$GITB $GTS$(date +%H:%M)"
    # FIXME: +9 działa przy starcie, ale gdy się sorsuje bashrc, okazuje się, że jest 2 za mało; skąd ta różnica??
    printf "%s%s%s%s%$(($COLUMNS-${#PS1L}+${#GTS}+19))s" "$BOLD" "$PSDIR" "$PS1L" "$RESET" "$PS1R"
}

PROMPT_COMMAND="print_pre_prompt; history -a; history -n"

# >>  - prompt string format
export PS1='\n\[$(exitstatus2)\]\[$BOLD\]\#\[$RESET\] \[$RESET\]'
export PS2='\[$ORANGE\]… \[$RESET\]'
#export PS1='\[$(exitstatus)\]\# \[$GREEN\]\w \[$RED\]$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[$RESET\] \[$ORANGE\]\$\[$RESET\] '
#export PS1='\[$(tput sc; rightp; tput rc)\]\[$BOLD\]\[$BLUE\]\w\[$RESET\]\n> '

# >> auto cd
shopt -s autocd

# >> VARIABLES:
export BROWSER=/usr/bin/qutebrowser
export VISUAL=""
export EDITOR='emacsclient -nw'
export ALTERNATE_EDITOR="nano"
export PATH=$PATH:~/bin:~/scr
export RANGER_LOAD_DEFAULT_RC=FALSE
# export TERM=xterm-xfree86

# >> VARIOUS:
# >>  - mutt background fix
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
    # [[ -n "$TMUX" ]] || trap 'echo -ne "\033]0;$BASH_COMMAND ($(date +%H:%M))\007"' DEBUG
    [[ -n "$TMUX" ]] || trap 'echo -ne "\033]0;$PWD ($(date +%H:%M))\007"' DEBUG
}
automatic_title

# >> HISTORY
export HISTCONTROL=ignoreboth:erasedups

