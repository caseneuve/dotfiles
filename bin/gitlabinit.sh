#!/bin/bash

# Path:        ~/.dotfiles/bin/gitlabinit.sh
# Created:     17.11.18, 19:53    @lenovo
# Last update: 16.01.19, 11:53:17 @x200

# >> DOC:
# init nonexistent repo on gitlab

# >> VARIABLES:
usage(){
    cat << EOF
 INIT A GITLAB REPOSITORY IN EXISTING DIRECTORY
 ==============================================
 usage: ${0##*/} [proj. name] [namespace]

 > project name  defaults to working directory
 > namespace     defaults to 'caseneuve'

EOF
    exit 0
}

if [[ -z $1 ]]; then
    PROJECT_NAME=${PWD##*/}
else
    if [[ $1 =~ -h|--help ]]; then
        usage
    else
        PROJECT_NAME=$1
    fi
fi

if [[ -z $2 ]]; then
    NAMESPACE=caseneuve
else
    NAMESPACE=$2
fi


# >> RUN:
while true; do
    read -p "## Im going to initialize a git repo on GitLab:
>  user:    $NAMESPACE
>  project: $PROJECT_NAME
>
>  Proceed? [Y/n] " answer
    if [[ $answer =~ y|Y ]] || [[ -z $answer ]]; then
        [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]] || git init
        git add .
        git commit -m 'GitLab initial commit'
        git push --set-upstream git@gitlab.com:$NAMESPACE/$PROJECT_NAME.git master
        git status
        exit 0
    elif [[ $answer =~ n|N ]]; then
        echo ">   Quit!"
        exit 1
    fi
done
 
