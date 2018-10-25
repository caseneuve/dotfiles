#!/bin/env python

# Path: /home/piotr/.dotfiles/i3/i3listen.py
# Last update: 25.10.18, 20:35:52 @x200

# >> DOC:
'''Connect to i3 ipc-socket, listen to events, make dynamic changes.
Active features:
- update wintitle on i3 bar
- boldify focused workspace name.'''

# >> TODOS:
# todo: 24/10/2018, display window title in workspace name instead of the right pane @ boldify (?)

# >> IMPORTS:
import i3ipc
import re
from subprocess import run

# >> VARIABLES:
i3 = i3ipc.Connection()

# >> FUNCS:
# >> kill blocks on window focus @func
def on_window_pkill(i3, e):
    'Reset i3wintitle script on the i3blocks bar.'
    run(['pkill', '-RTMIN+2', 'i3blocks'])


# >> boldify workspace @func
def boldify_wksp_name(i3, e):
    '''Boldify workspace name when focused, unboldify others. Side effect: renamed workspace will be transferred on the top of the stack (i.e. the last wksp on the right).'''
    # >>> variables @bol
    tree = i3.get_tree()            
    clear_name_re = re.compile(r'<.*>([A-Za-z\+/]*)</.*>')
    workspaces = tree.workspaces()
    focused_workspace = tree.find_focused().workspace()
    # >>> unboldify not focused workspaces @bol
    for w in workspaces:
        if "span" in w.name and w.name != focused_workspace.name:
            # print(f'UNBOLD: {w.name}') # test
            w.command(f'rename workspace "{w.name}" to "{clear_name_re.search(w.name).group(1)}"')
    # >>> make sure current workspace is boldified @bol 
    if "span" not in focused_workspace.name:
        #print(f"spanuję w {focused_workspace.name}") # test
        new  = f"<span weight='bold'>{focused_workspace.name}</span>"
        focused_workspace.command(f'rename workspace to "{new}"')

    
# >> [off] window border @func
# def window_border(i3, e):
#     cons = i3.get_tree().leaves() 
#     foc = i3.get_tree().find_focused()
#     for i in cons:
#         i.command('border none')
#     foc.command('border pixel 1')


# >> SUBSCRIBE TO EVENTS:
#I3.on('workspace::focus', on_workspace_focus)
#i3.on("window::focus", window_border)
i3.on("window::focus", on_window_pkill)
i3.on("window::title", on_window_pkill)
i3.on("workspace::focus", on_window_pkill)
i3.on("workspace::focus", boldify_wksp_name)


# >> Start the main loop and wait for events to come in
i3.main()
