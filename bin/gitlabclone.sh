#!/bin/bash

# Path:        ~/.dotfiles/bin/gitlabclone.sh
# Created:     18.11.18, 10:57    @toshiba
# Last update: 18.11.18, 12:28:19 @toshiba

# >> DOC:
# clone gitlab repo providing only its name

# >> VARIABLES: 
if [[ -z $1 ]]; then
    PROJECT_NAME=${PWD##*/}
else
    PROJECT_NAME=$1
fi

if [[ -z $2 ]]; then
    DIR=$PROJECT_NAME
else
    DIR="$2"
fi

if [[ -z $3 ]]; then
    NAMESPACE=caseneuve
else
    NAMESPACE=$3
fi

# >> FUNC:
usage () {
    cat << EOF
# gitlabclone:
  usage: ${0##/home/piotr/bin/} [project name] [[destination path]] [[namespace]]

  \$1   is obligatory
  \$2   defaults to working dir: "./$PROJECT_NAME"
  \$3   defaults to "$NAMESPACE"

EOF
}

# >> RUN:
if [[ -z $@ ]]; then
    usage
else
    git clone git@gitlab.com:$NAMESPACE/$PROJECT_NAME.git "$DIR"
    ls --color=always "$DIR"
fi

