#!/bin/bash

# Path:        ~/.dotfiles/i3quick-help.sh
# Created:     20.05.18, 10:52    @lenovo
# Last update: 02.02.19, 18:44:31 @lenovo

# Doc:
# mod+f1

notify-send "[i3 KBD HELPER]:" \
"\===============
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
