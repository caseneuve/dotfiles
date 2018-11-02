#!/bin/bash

# Path:        ~/.dotfiles/bashrc-bak.sh
# Created:     02.11.18, 18:28    @x200
# Last update: 02.11.18, 18:31:56 @x200
# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 

# >> RUN: 

# # >>> + exitstatus
# exitstatus() {
#     if [[ $? == 0 ]]; then
#         echo $BLUE
#     else
#         echo $RED
#     fi
# }

# exitstatus2() {
#     [[ ! $? == 0 ]] && echo $RED || echo "$(tput setaf 240)" 
# }

# >>> + print_pre_prompt
# print_pre_prompt () {
#     PS1L=$PWD
#     [[ $PS1L/ = "$HOME"/* ]] && PS1L=\~${PS1L#$HOME}
#     GTS=$(git status 2>/dev/null)
#     GITB=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
#     GITB=$BOLD$PSGIT$GITB$RESET
#     case $GTS in
#         *'use "git push"'*) GTS=$ORANGE$(echo -e '\u2714 ')$RESET;; 
#         *'nothing to commit'*) GTS=$GREEN$(echo -e '\u2714 ')$RESET;; 
#         *'not staged'*|*'Untracked'*|*'modified'*|*'to be committed'*|*'deleted') GTS=$ORANGE$(echo -e '\u2717 ')$RESET;;
#         *) GTS= ;;
#     esac
#     PS1R="$GITB $GTS$(date +%H:%M)"
#     # FIXME: +9 działa przy starcie, ale gdy się sorsuje bashrc, okazuje się, że jest 2 za mało; skąd ta różnica??
#     printf "%s%s%s%s%$(($COLUMNS-${#PS1L}+${#GTS}+19))s" "$BOLD" "$PSDIR" "$PS1L" "$RESET" "$PS1R"
# }
