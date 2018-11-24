#!/bin/bash

# Path:        ~/.dotfiles/weechat/weechat_setup.sh
# Created:     24.11.18, 23:39    @x200
# Last update: 25.11.18, 00:57:07 @x200

# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 
VENVS=$HOME/.virtualenvs
VIRTWEE=$VENVS/weechatpy2
WEE=$HOME/.weechat
WEELUA=$WEE/lua
WEEPY=$WEE/python
WEEPERL=$WEE/perl

# >> RUN:
clear
echo "===================="
echo "## WEECHAT SETUP! ##"
echo ""
read -p "Confirm that you are running this script as sudo [y/n] " confirm
if [[ $confirm != y ]]; then
    echo "Run this script as root!"
    exit 1
fi

echo "Checking dependencies..."
echo "... Installing:"
for app in python2 python2-virtualenv weechat; do
    if [[ $(pacman -Q $app 2>/dev/null) ]]; then
        echo "... $app"
        pacman --no-confirm -S $app
done

echo "... lua-cjson"
yay lua-cjson

echo "Running weechat just to build directory structure..."
weechat &
sleep 2
pkill weechat

echo "Making a python virtual environment in $VIRTWEE..."
[[ -d $VENVS ]] || echo "... mkd $VIRTWEE"; mkdir $VENVS
cd $VENVS
[[ -d $VIRTWEE ]] || "... running virtualenv2"; virtualenv2 $VIRTWEE
cd $VIRTWEE
source ./bin/activate
echo "... installing pync and websocket-client"
pip install pync
pip install websocket-client
echo "... done!"
echo ""
echo "Installing some plugins: 
- *matrix-protocol*, 
- *multiline.pl* 
- *wee_slack.py*"
echo -e "(more info
- https://github.com/torhve/weechat-matrix-protocol-script
- https://github.com/wee-slack/wee-slack 
- https://weechat.org/scripts/source/multiline.pl.html/ )"

cd /tmp
echo "... cloning matrix-protocol"
git clone https://github.com/torhve/weechat-matrix-protocol-script.git
echo "... downloading multiline"
wget https://weechat.org/files/scripts/multiline.pl
echo "... downloading wee_slack"
wget https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py
echo "... moving files to [1] $WEELUA , [2] $WEEPERL and [3] $WEEPY respectively"
cp weechat-matrix-protocol-script/matrix.lua $WEELUA/ && echo "... [1] done"
cp multiline.pl $WEEPERL/ && echo "... [2] done"
cp wee_slack.py $WEEPY/ && echo "... [3] done"

echo "... linking files to autoload folders"
ln -s $WEELUA/matrix.lua $WEELUA/autoload/
ln -s $WEEPERL/multiline.pl $WEEPERL/autoload/
ln -s $WEEPY/wee_slack.py $WEEPY/autoload/
echo "... done!"
echo ""
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
   `source VIRTWEE/bin/activate`

## WEECHAT SETUP COMPLETE ##
============================
EOF

