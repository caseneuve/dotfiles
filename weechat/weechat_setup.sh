#!/bin/bash

# Path:        ~/.dotfiles/weechat/weechat_setup.sh
# Created:     24.11.18, 23:39    @x200
# Last update: 25.11.18, 11:48:34 @toshiba

# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 
VENVS=$HOME/.virtualenvs
VIRTWEE=$VENVS/weechatpy2
WEE=$HOME/.weechat
WEELUA=$WEE/lua
WEEPY=$WEE/python
WEEPERL=$WEE/perl
gre=$(tput setaf 2)
red=$(tput setaf 9)
blu=$(tput setaf 4)
res=$(tput sgr0)
# >> RUN:
clear
echo $gre
cat << EOF
###############################################
__        _______ _____ ____ _   _    _  _____ 
\ \      / / ____| ____/ ___| | | |  / \|_   _|
 \ \ /\ / /|  _| |  _|| |   | |_| | / _ \ | |  
  \ V  V / | |___| |__| |___|  _  |/ ___ \| |  
   \_/\_/  |_____|_____\____|_| |_/_/   \_\_|  
                                               
                    _               
           ___  ___| |_ _   _ _ __  
          / __|/ _ \ __| | | | '_ \ 
          \__ \  __/ |_| |_| | |_) |
          |___/\___|\__|\__,_| .__/ 
                             |_|    
##############################################

EOF
echo $res

echo $gre
echo "# Checking dependencies..."
echo "# ... Installing:"
echo $res

for app in python2 python2-virtualenv weechat
do
    if [[ ! $(pacman -Q $app 2>/dev/null) ]]; then
        echo $gre "# ... $app" $res
        yay -S $app
    else
        echo $red "# ... skipping $app" $res
    fi
done

echo $gre
echo "# ... lua-cjson"
echo $res
yay lua-cjson

echo $gre
echo "# Running weechat just to build directory structure..."
echo $res
weechat -r '/key bind meta-t /bar toggle buflist; /key bind meta-n /bar toggle nicklist; /key bind meta-s /input return; /save; /quit' 

echo $gre
echo "# Making a python virtual environment in $VIRTWEE..."
echo $res
if [[ -d $VENVS ]]; then
    echo $red "# ... $VENVS exists!" $res
else
    echo $gre "# ... mkd $VENVS" $res
    mkdir $VENVS
fi

     
cd $VENVS
if [[ -d $VIRTWEE ]]; then
    echo $red "# ... $VIRTWEE exists, skipping!" $res
else
    echo $gre "#... running virtualenv2" $res
    virtualenv2 $VIRTWEE
fi


cd $VIRTWEE
source $VIRTWEE/bin/activate
echo $gre
echo "# ... installing *pync* and *websocket-client*"
echo $res
pip install pync
echo $gre
echo "# ... done!"
echo $res 
pip install websocket-client
echo $gre
echo "# ... done!"
echo -e "\n# Installing some plugins: 
  - *matrix-protocol*, 
  - *multiline.pl* 
  - *wee_slack.py*"
echo "# (more info at: $blu 
  - https://github.com/torhve/weechat-matrix-protocol-script 
  - https://github.com/wee-slack/wee-slack 
  - https://weechat.org/scripts/source/multiline.pl.html/ $gre)$res"
echo $res

cd /tmp
echo $gre
echo "# ... cloning *matrix-protocol*"
echo $res
git clone https://github.com/torhve/weechat-matrix-protocol-script.git

echo $gre
echo "# ... downloading *multiline*"
echo $res
wget https://weechat.org/files/scripts/multiline.pl

echo $gre
echo "# ... downloading *wee_slack*"
echo $res
wget https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py

echo $gre
echo "# ... moving files to:
#  [1] $WEELUA, 
#  [2] $WEEPERL,
#  [3] $WEEPY respectively"
echo $res


cp /tmp/weechat-matrix-protocol-script/matrix.lua $WEELUA/ && echo "$gre# ... [1] done $res"
cp /tmp/multiline.pl $WEEPERL/ && echo "$gre# ... [2] done $res"
cp /tmp/wee_slack.py $WEEPY/ && echo "$gre# ... [3] done $res"

echo $gre
echo "# ... creating symlinks in /autoload folders"
echo $res

[[ -L $WEELUA/autoload/matrix.lua ]] || ln -s $WEELUA/matrix.lua $WEELUA/autoload/
[[ -L $WEEPERL/autoload/multiline.pl ]] || ln -s $WEEPERL/multiline.pl $WEEPERL/autoload/
[[ -L $WEEPY/autoload/wee_slack.py ]] || ln -s $WEEPY/wee_slack.py $WEEPY/autoload/
echo $gre
echo "# ... done!"
echo $res

echo $red
cat << EOF
## instructions ##
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

Before running weechat remember to run:
   "source $VIRTWEE/bin/activate"

EOF
echo $res

while true; do
    echo "# Do you want to start weechat with autoconfigure?"
    read -sp "# (you will need to pass some credentials) [y/n] " answer
    if [[ $answer == "n" ]]; then
        echo $gre
        echo "============================
## WEECHAT SETUP COMPLETE ##
============================
"
        echo $res
        exit 0
    else
        while true; do
            echo -e "\n"
            read -p "$gre# Enter your *matrix* login: $res" matrix_log
            read -sp "$gre# Enter your *matrix* password: $res" matrix_pass
            echo ""
            read -p "$gre# Correct? [y/n] $res" correct
            [[ $correct == "y" ]] && break
        done
        echo $gre
        echo -e "\n# Starting WeeChat with autoconfigure..."
        echo $res
        sleep 3

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

