#!/bin/env python

# Path: /home/piotr/.dotfiles/i3/i3listen.py
# Last update: 15.08.18, 15:00:52 @x200

# >> DOC:

# >> TODOS:
# todo: 24/10/2018, display window title in workspace name instead of the right pane @ boldify


# >> IMPORTS:
import i3ipc
import re
from subprocess import run

# >> VARIABLES:
i3 = i3ipc.Connection()

# >> FUNCS:
# >> kill blocks on window focus @func
def on_window_pkill(i3, e):
    run(['pkill', '-RTMIN+2', 'i3blocks'])

# >> window border @func
def window_border(i3, e):
    cons = i3.get_tree().leaves() 
    foc = i3.get_tree().find_focused()
    for i in cons:
        i.command('border none')
    foc.command('border pixel 1')


# >> boldify @func
def boldify_wksp_name(i3, e):
    tree = i3.get_tree()
    name_re = re.compile(r'<.*\'>([A-Za-z\+/]*)</span>')
    allw = tree.workspaces()
    for w in allw:
        if "span" in w.name and not w.focused:
            w.command(f'rename workspace "{w.name}" to "{name_re.search(w.name).group(1)}"')

    foc = tree.find_focused().workspace()
    new = f"<span weight='bold'>{foc.name}</span>"
    foc.command(f'rename workspace to "{new}"')
   

# >> SUBSCRIBE TO EVENTS:
#I3.on('workspace::focus', on_workspace_focus)
i3.on("window::focus", window_border)
i3.on("window::focus", on_window_pkill)
i3.on("window::title", on_window_pkill)
i3.on("workspace::focus", on_window_pkill)
i3.on("workspace::focus", boldify_wksp_name)


# >> Start the main loop and wait for events to come in.
i3.main()

