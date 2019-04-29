#!/bin/bash

# Path:        ~/.dotfiles/bin/gitlabinit.sh
# Created:     17.11.18, 19:53    @lenovo
# Last update: 2019-04-29, 12:08:40 @toshiba
# Doc:         init (nonexistent) repo on gitlab
# Todo:        26/04/2019 set local user.name/mail if ≠ global

SSH=~/.ssh
PROJECT_NAME=${PWD##*/}
NAMESPACE=$(git config --global --get user.name)

usage(){
    cat << EOF
 gitlabinit: init a gitlab repository in existing directory
 
 usage: ${0##*/} [[-p <project name>][-n <namespace>]]

  - project name  defaults to working directory
  - namespace     defaults to user.name set in git config file

EOF
    exit 0
}

while getopts "n:p:h" args; do
    case "${args}" in
        n) NAMESPACE="$OPTARG" ;;
        p) PROJECT_NAME="$OPTARG" ;;
        *) usage ;;
    esac
done

while true; do
    read -p "## Initializing a git repo on GitLab:
>  user:    $NAMESPACE
>  project: $PROJECT_NAME
>
>  Proceed? [Y/n] " answer
    if [[ $answer =~ y|Y ]] || [[ -z $answer ]]; then
        echo ">  Select ssh key: "
        PS3=">  "
        select ssh_key in $(fd -t f -E "*.pub" -E "config" -E "known_hosts" -E "xclip" . $SSH | sed "s|$SSH/||g"); do
            if [ -n "$ssh_key" ]; then
                git remote rm origin
                [[ $(git config --local --list | grep "sshcommand") ]] \
                    && git config --local --unset core.sshCommand
                git config --local --add core.sshCommand "ssh -i ~/.ssh/$ssh_key"
            else
                echo ">  No key specified, using default..."
            fi
            break
        done
        if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
            git add .
            git commit -m 'GitLab committing to $NAMESPACE/$PROJECT_NAME'
        else
            git init
            git add .
            git commit -m 'GitLab initial commit'
        fi
        # HACK? intended for patched repos
        # [[ $(git branch | wc -l) -eq 1 ]] && branch=$(git branch | sed 's/* //') || branch=master 
        git push --all --set-upstream \
            git@gitlab.com:$NAMESPACE/$PROJECT_NAME.git master 
        git remote add origin git@gitlab.com:$NAMESPACE/$PROJECT_NAME.git
        git status
        exit 0
    elif [[ $answer =~ n|N ]]; then
        echo ">  Quit!"
        exit 1
    fi
done
 
