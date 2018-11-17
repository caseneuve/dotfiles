#!/bin/bash

# Path:        ~/.dotfiles/bin/gitlabinit.sh
# Created:     17.11.18, 19:53    @lenovo
# Last update: 17.11.18, 20:14:15 @lenovo
# >> DOC:
#init nonexistent repo on gitlab

# >> TODOS: 

# >> VARIABLES: 
if [[ -z $1 ]]; then
    PROJECT_NAME=${PWD##*/}
else
    PROJECT_NAME=$1
fi

if [[ -z $2 ]]; then
    NAMESPACE=caseneuve
else
    NAMESPACE=$2
fi

while true; do
    read -p "## Im going to initialize a git repo on GitLab:
>  user:    $NAMESPACE
>  project: $PROJECT_NAME
>
>  Proceed? [Y/n] " answer
    if [[ $answer =~ y|Y ]] || [[ -z $answer ]]; then
        git init
        git add .
        git commit -m 'initial commit'
        git push --set-upstream git@gitlab.com:$NAMESPACE/$PROJECT_NAME.git master
        git status
        # echo ok
        exit 0
    elif [[ $answer =~ n|N ]]; then
        echo ">   Quit!"
        exit 1
    fi
done

        

        
# >> RUN:
# git init
# git add .
# git commit -m 'initial commit'
# git push --set-upstream git@gitlab.com:$NAMESPACE/$PROJECT_NAME.git master
# git status
