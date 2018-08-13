#!/bin/env python

import i3ipc, subprocess
i3 = i3ipc.Connection()

# Dynamically name your workspaces after the current window class
def on_window_pkill(i3, e):
    subprocess.run(['pkill', '-RTMIN+2', 'i3blocks'])


def window_border(i3, e):
    foc = i3.get_tree().find_focused()
    foc.command('border pixel 1')
    
# Subscribe to events
#i3.on('workspace::focus', on_workspace_focus)
i3.on("window::focus", window_border)
i3.on("window::focus", on_window_pkill)
i3.on("window::title", on_window_pkill)
i3.on("workspace::focus", on_window_pkill)

# Start the main loop and wait for events to come in.
i3.main()

