#!/bin/bash

# Path:        ~/.dotfiles/weechat/weechat_setup.sh
# Created:     24.11.18, 23:39    @x200
# Last update: 09.12.18, 16:10:36 @x200

# >> DOC:
# Read info under the banner

# >> TODOS: 
# xdg open:  https://slack.com/oauth/authorize?client_id=2468770254.51917335286&scope=client
# and paste the code here so that slack authentication goes automatically in weechat

# >> VARIABLES: 
VENVS=$HOME/.virtualenvs
VIRTWEE=$VENVS/weechatpy2
WEE=$HOME/.weechat
WEELUA=$WEE/lua
WEEPY=$WEE/python
WEEPERL=$WEE/perl
WEERUBY=$WEE/ruby
DOTFILES=$HOME/.dotfiles/weechat
gre=$(tput setaf 2)
red=$(tput setaf 9)
blu=$(tput setaf 4)
res=$(tput sgr0)

# >> RUN:
clear
echo $gre
cat << EOF
#####################################################
#  __        _______ _____ ____ _   _    _  _____   #
#  \ \      / / ____| ____/ ___| | | |  / \|_   _|  #
#   \ \ /\ / /|  _| |  _|| |   | |_| | / _ \ | |    #
#    \ V  V / | |___| |__| |___|  _  |/ ___ \| |    #
#     \_/\_/  |_____|_____\____|_| |_/_/   \_\_|    #
#                                                   #
#                      _                            #
#             ___  ___| |_ _   _ _ __               #
#            / __|/ _ \ __| | | | '_ \              #
#            \__ \  __/ |_| |_| | |_) |             #
#            |___/\___|\__|\__,_| .__/              #
#                               |_|                 #
#####################################################
EOF
echo $red
cat << EOF
# This script will install weechat and some dependencies 
# which are necessary to properly run the app.
# Protocol to connect with *matrix.org* and plugin for 
# *slack* will be added as well as some other plugins.
# Virtual environment to run slack plugin will be created.
# Scripts allows to automate login into matrix.org 
# (automatic login to slack is on the todo list).

# Apps which will be installed (currently with yay):
# ============================
# - weechat
# - python2
# - python2-virtualenv
# - lua-cjson (aur)

# Plugins:
# =======
# - matrix-protocol   => plugin for matrix.org
# - wee_slack.py      => plugin for slack
# - urls.rb           => urlview launcher)
# - multiline.pl      => multiline entries support
# - go.py             => support for quick jumping to buffers
# - weenotify         => send system notifications
# - colorize_nicks.py => (don't know if needed :-))

EOF
echo $res
while true; do
    read -p "# Proceed? [y/n] " proceed
    if [[ $proceed =~ y|Y || -z $proceed ]]; then
        break
    elif [[ $proceed =~ n|N ]]; then
        echo $red
        echo "# Quitting WEECHAT SETUP!"
        echo $res
        exit 1
    else
        echo "Enter y or n"
    fi
done

# >>> installing dependencies
echo $gre
echo "# Checking dependencies..."
echo $res

for app in python2 python2-virtualenv weechat lua-cjson; do
    if [[ ! $(pacman -Q $app 2>/dev/null) ]]; then
        echo $gre"# ... installing $app" $res
        yay -S $app
    else
        echo $red"# ... $app already installed, skipping" $res
    fi
done

# >>> run weechat for the first time
echo $gre
echo "# Running weechat to build directory structure and install some official scripts..."
echo $res
weechat -r '/script install go.py; /script install colorize_nicks.py; /script install weenotify.py; /set plugins.var.python.weenotify.enable "on"; /save; /quit' 

# >>> symlinks
echo $gre
echo "# Linking config files from ~/.dotfiles repo..."
echo $res
if [[ -d $DOTFILES ]]; then
    for file in $(ls $DOTFILES/*.conf); do
        file=${file##*/}
        if [[ -L $WEE/$file ]]; then
            echo $red"# ... symlink $file already exists!"$res
        else
            [[ -f $WEE/$file ]] && rm $WEE/$file
            ln -s $DOTFILES/$file $WEE && echo $gre"# ... symlink for $file done!"$res
        fi
    done
fi
echo $res

# >>> virtualenv
echo $gre
echo "# Creating a python2 virtual environment in $VIRTWEE..."
echo $res
if [[ -d $VENVS ]]; then
    echo $red"# ... $VENVS exists!" $res
else
    echo $gre"# ... mkd $VENVS" $res
    mkdir $VENVS
fi

cd $VENVS
if [[ -d $VIRTWEE ]]; then
    echo $red"# ... $VIRTWEE exists, skipping!" $res
else
    echo $gre"#... running virtualenv2" $res
    virtualenv2 $VIRTWEE
fi

echo $gre
echo "# ... checking Python requirements:"
echo $res
source $VIRTWEE/bin/activate
pip install -r "$DOTFILES/requirements.txt"

# >>> installing external plugins
echo $gre
echo "# Installing the plugins: 
  - *matrix-protocol*, 
  - *wee_slack.py*
  - *urls.rb*"
echo "# (more info at: $blu 
  - https://github.com/torhve/weechat-matrix-protocol-script 
  - https://github.com/wee-slack/wee-slack 
  - https://weechat.org/files/scripts/unofficial/urlview.rb $gre)"

cd /tmp
external_script(){
    if [[ -f "$2/$1" ]]; then
        echo $red"# ... plugin $1 already installed!"$res
    else
        echo $gre"# ... cloning *$1*"$res
        [[ $(echo $3 | grep git) ]] && git clone $3 $2 || wget -P $2 $3
        echo -n $gre"# ... symlinking $1 to $2/autoload/$1"
        [[ -L $2/autoload/$1 ]] || ln -s $2/$1 $2/autoload/
        echo " ... done!"
        echo $res
    fi
}

external_script matrix.lua \
                $WEELUA \
                https://github.com/torhve/weechat-matrix-protocol-script.git

external_script wee_slack.py \
                $WEEPY \
                https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py

external_script urlview.rb \
                $WEERUBY \
                https://weechat.org/files/scripts/unofficial/urlview.rb

# >>> final message
echo $red
cat << EOF
## Instructions ##
==================

1. *matrix*
   (/script load matrix.lua)
   /set plugins.var.lua.matrix.user username
   /set plugins.var.lua.matrix.password secret
   /matrix connect

2. *multiline*
   /key bind meta-s /input return
   (more in the script)

3. *slack*
   /slack register
   (and follow instructions in weechat)

4. some useful kbd
   /key bind meta-t /bar toggle buflist
   /key bind meta-n /bar toggle nicklist
   Alt+j <num> → goto buffer <num>
   Alt+[0..9]  → goto buffer [0-9]
   F1 / F2     → buflist beg / end
   C-n / C-p   → next / prev buffer
   Alt+q       → kill buffer
   Alt+g       → select buffer to go
   Alt+a       → last action buffer
   Alt+/       → previously focused buffer

# Before running weechat remember to run:
  "source $VIRTWEE/bin/activate"
  or
  "$VIRTWEE/python weechat"
EOF
echo $res

# >>> last configs
while true; do
    echo "# Do you want to start weechat with autoconfigure?"
    read -p "# (you will need to pass some credentials) [y/n] " answer
    if [[ $answer =~ n|N ]]; then
        echo $gre
        echo "# Weechat has been installed, finish your setup manually."
        echo $res
        exit 0
    else
        while true; do
            echo -e "\n"
            read -p "$gre# Enter your *matrix* login: $res" matrix_log
            read -sp "$gre# Enter your *matrix* password: $res" matrix_pass
            echo ""
            read -p "$gre# Correct? [y/n] $res" correct
            [[ $correct =~ y|Y || -z $correct ]] && break
        done
        echo $gre
        echo -e "\n# Starting WeeChat with autoconfigure..."
        echo $res
        sleep 2

        source $VIRTWEE/bin/activate
        weechat -r "/set plugins.var.lua.matrix.user $matrix_log; /set plugins.var.lua.matrix.password $matrix_pass; /script reload matrix.lua; /matrix connect; /slack register"

        echo $gre
        echo "============================
## WEECHAT SETUP COMPLETE ##
============================
"
        echo $res
        exit 0
    fi
done

