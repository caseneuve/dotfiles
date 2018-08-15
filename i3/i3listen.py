#!/bin/env python

# Path: /home/piotr/.dotfiles/i3/i3listen.py
# Last update: 15.08.18, 15:00:52 @x200

# >> DOC:

# >> IMPORTS:
import i3ipc
from subprocess import run

# >> VARIABLES:
i3 = i3ipc.Connection()

# >> FUNCS:
# Dynamically name your workspaces after the current window class
def on_window_pkill(i3, e):
    run(['pkill', '-RTMIN+2', 'i3blocks'])

def window_border(i3, e):
    cons = i3.get_tree().leaves() 
    foc = i3.get_tree().find_focused()
    for i in cons:
        i.command('border none')
    foc.command('border pixel 1')
    
# >> SUBSCRIBE TO EVENTS:
#I3.on('workspace::focus', on_workspace_focus)
i3.on("window::focus", window_border)
i3.on("window::focus", on_window_pkill)
i3.on("window::title", on_window_pkill)
i3.on("workspace::focus", on_window_pkill)

# Start the main loop and wait for events to come in.
i3.main()

