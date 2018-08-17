#!/bin/env python

# >> DOC:

# >> TODOS:
# >> TODO: clean idiosyncratic names (eg cut out "qutebrowser from qtb etc."):
# - [x] qutebrowser
# - [ ] mpv
# >> TODO: czy da się dostać do tmuxa?; note: tak, ale nie wiem jak updatować skrypt, gdy już się jest w tmuksie
# >> TODO: glyphs
# lista:
# obrazy: gpick, gimp, mypaint
# wideo: mpv, vlc
# www: chrome, chromium, firefox
# dirs: thunar, ranger
# mail: neomutt, mutt
# social: slack, hangups?
# calendar: calcurse
# calc: R
# wifi: (netmanager?)
# py? (ipython)

# DONE: gdy zmienia się okno emacsa nie emituje się zmiana sygnału, więc pozostaje pierwszy tytuł (trzeba było dodać `i3.on("window::title", on_window_pkill)` do i3listen.py), note:05/08/2018
# DONE: make a dict {('st': icon), ('emacs': icon)}, NOTE: 05/08/2018, trzeba tylko ściągnąć odpowiednie glify
# DONE: search for key and return icon, else return class, note: 05/08/2018
# DONE: make a script that listens to i3 and responds when window changes focus
# DONE: shorten name, note: 05/08/2018

# >> IMPORTS
import i3ipc
import re
from subprocess import check_output as out  

# >> VARIABLES
i3 = i3ipc.Connection()
tree = i3.get_tree()
focused = tree.find_focused()
i3class = focused.window_class
i3name = focused.name

# >> IF FOCUS IS ON EMPTY WORKSPACE, RESET THE TITLE
if i3class == None:
    i3name = ''
    i3class = ''

# >> MUPDF: GET PAGE NUMBER FIRST
mupdfRe = re.compile(r'([a-z0-9 ._-]*)(.pdf - )([0-9]+/[0-9]+)', re.I)
if i3class == 'MuPDF':
    i3name = f'[{mupdfRe.search(i3name).group(3)}] {mupdfRe.search(i3name).group(1)}'

# >> CLASS ICONS DICT
class_dict = {'Emacs': '',
              'MuPDF': '',
              'qutebrowser': '',
              'Firefox': '', 
              'st-256color': '',
              'Thunar': '',
              'neomutt': '',
              'mpv': '',
              'Sxiv': '',
              'feh': '',
              'Gimp-2.10': '',
              'MyPaint': ''
}

# >> CHANGE ICON DICT
if i3class in class_dict:
    i3class = class_dict[i3class]

name_dict = {'neomutt': '',
             'ranger': '',
             'calcurse': '',
             'MOC [stop]': '',
             'MOC [play]': '',
}
if i3name in name_dict:
    i3class = name_dict[i3name]

# >> CHANGE NAME DICT
special_dict = { 'dropdown': 'tmux',
                 'm4ath': 'R calc',
} 
if i3name in special_dict:
    i3name = special_dict[i3name]

# >> TMUX
# if 'dropdown' in i3name:
#     tmux_windows = out(['tmux', 'list-windows']).decode('utf-8').split('\n')
#     for name in tmux_windows:
#         if "active" in name:
#             i3name = 'tmux: ' + name.split(' ')[1][:-1]
    
# >> REMOVE SOME UNNECESARY INFO 
removeRe = re.compile(r' - qutebrowser|sxiv -|feh|^Firefox |^Home \| |\| GitLab|Slack ')
if removeRe.search(i3name):
    i3name = re.sub(removeRe, '', i3name)

# >> SHORTEN WINDOW NAME
if len(i3name) > 50:
    i3name = i3name[0:50] + "..."

# >> RETURN string for i3blocks
# skoryguj niedozwolone znaki
if '\n' in i3name:
    i3name = 'shell command'

print(f"<span weight='bold'>{i3class}  {i3name}</span>")
#print(f"<span weight='bold'>{i3name}</span>")

