#!/bin/bash

# Path:        ~/.dotfiles/i3quick-help.sh
# Created:     20.05.18, 10:52    @lenovo
# Last update: 2019-11-05, 23:15:54 @lenovo
# Doc:         i3 kbd helper, mod+f1

notify-send -u low -t 10000 "i3 KBD HELPER" "\n===============
focus parent   = W+p
tabbed         = W+C+t
stacked        = W+C+s
toggle         = W+y
mark           = W+a
move to marked = W+C+a
swap /w marked = W+'
---------------
log out       = W+S+bs
change ws     = W+num
launch an app = W+d
---------------
video mode      = W+S+v
sticky toggle   = W+v
floating toggle = W+S+space
---------------
shot whole screen    = PrtSc
shot current window  = W+PrtSc
shot selected window = W+S+PrtSc
---------------
screencast start = W+f12
screencast stop  = W+Ctrl+f12
===============
[WEECHAT]:
2+:joy: = react to second msg with
          emoji 
/reply 1 <msg> = start a thread 
            replying last msg
s/// = delete (last) msg
3s/old text/new text/[g] = rep str
/thread <code> = open a thread
===============
[MPV]:
&lt;, &gt;   = prev, next item on list
"
