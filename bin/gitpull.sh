#!/bin/bash

# Path:        ~/.dotfiles/bin/gitpull.sh
# Created:     2019-03-04, 12:39    @x200
# Last update: 2019-03-04, 16:48:50 @x200
# Doc:         update all active repos

DOT=$HOME/.dotfiles
SCHOLE=$HOME/web/schole
LAB=$HOME/git/lab
HUB=$HOME/git/hub 

gitpull(){
    cd $1
    if [[ -d .git ]]
    then
        echo "## Pulling from repo -- $BOLD$(basename $1)$RESET:"
        git status --porcelain
        git pull
        echo
    else
        echo "!! $1 is not a git repo"
    fi
}

main() {
    # update dotfiles, bashrc and Xresources
    gitpull $DOT
    . $HOME/.bashrc
    cp $HOME/.dotfiles/Xresources/Xresources $HOME/.Xresources \
        && xrdb $HOME/.Xresources
        
    # update other repos
    for dir in $SCHOLE $LAB $HUB
    do
        for repo in $(fd -t d -d 1 . $dir)
        do
            gitpull $repo
        done
    done
    
    # tangle emacs config
    $HOME/git/lab/dotemacs/tangle-config-org.sh
    emacs --daemon &
    
    notify-send "GIT PULL" "All repos should be updated now"
}

main
