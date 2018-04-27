#!/bin/bash

# Path:        ~/.bin/dmenu-kill.sh
# Created:     26.04.18, 20:25    @manjaroi3
# Last update: 27.04.18, 19:46:28 @manjaroi3

# Doc: show apps on active windows to chose via dmenu and kill chosen one 

# dmenu preamble
# if [[ -f ~/.dmenurc ]]; then
#     . ~/.dmenurc
# else
DMENU="dmenu -i -sb #a52a2a -nb #000000 -nf #2980b9"
# fi

# fixme: how to read bashrc variable?
terminal=$(grep -v '#' ~/.bashrc | grep TERMINAL | tr "=" " " | awk '{print $(NF)}')

# get active apps names and titles from i3 tree: 
list=$(i3-msg -t "get_tree" | grep -oE '{"class":"[a-zA-Z0-9 -]*","instance":"[A-Za-z0-9 -]*","title":"[][a-zA-Z\.0-9\*?%\(\)|:!~@/& -]*"|{"class":"[a-zA-Z]*","instance":"[A-Za-z0-9 -]*","window_role":"[A-Za-z ]*","title":"[a-zA-Z\.0-9\* -]*"' | sed 's/,"instance":"[a-zA-Z0-9 -]*"//g' | sed 's/,"window_role":"[a-z]*"//g' | sed 's/"class":"//g' | sed 's/","title":/ /g' | grep -v -E "\"$terminal\"|\"dropdown\"|\"math\"|\"i3bar")

# choose app to kill:
x=$(echo $list | sed 's/" /"\n/g' | $DMENU -l 100 -p "CHOOSE APP TO KILL")

# chosen app name:
y=$(echo $x | awk '{print $1}')
# chosen app title:
z=$(echo $x | awk '{print $2}' | sed 's/"//g')

# check if input passed to dmenu is correct:
if [[ $(echo $list | grep $y) ]]; then
    # if chosen app is running from terminal
    if [[ $(echo $y | grep "st-256color") ]]; then
        ps aux | grep "st" | grep -i $z | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    else
        ps aux | grep -i $y | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    fi
fi


# {SCRATCH}
#ps aux | grep -i $(echo $x | awk '{print $1}') | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

# get apps running on active windows (don't count apps with number in name, e.g. i3-bar or st-256color)
#list=$(i3-msg -t "get_tree" | grep -o '{"class":"[A-Za-z-]*"' | sed 's/{\"class\"://' | sed 's/\"//' | sed 's/\"//')

# pass active apps to dmenu
#x=$(echo $list | tr " " "\n" |$DMENU -p "Choose app to kill" -l $(echo $list | awk '{print NF}'))

# pass chosen app to kill
#[[ $(echo $list | grep $x) ]] && ps aux | grep -i $x | awk {'print $2'} | xargs kill -9 > /dev/null 2>&1

#list="Slack Skype Thunar Gimp Gpick Firefox Libreoffice Impress"
#x=$(echo $list | tr " " "\n" | $DMENU -p "Choose app to kill" -l $(echo "$list" | awk '{print NF}'))

