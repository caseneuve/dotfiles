#!/bin/env python

# >> DOC:
# ====
# >> TODO: clean idiosyncratic names (eg cut out "qutebrowser from qtb etc."):
# - [x] qutebrowser
# - [ ] mpv
# >> TODO: czy da się dostać do tmuxa?
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

# >> PRELIMINARY SETTINGS
import i3ipc, subprocess, re

i3 = i3ipc.Connection()
tree = i3.get_tree()
focused = tree.find_focused()
i3class = focused.window_class
i3name = focused.name

# >> if focus is on empty workspace make it clean
if i3class == None:
    i3name = ''
    i3class = ''

# >> mupdf: get page number first!
mupdfRe = re.compile(r'([a-z0-9 ._-]*)(.pdf - )([0-9]+/[0-9]+)', re.I)
if i3class == 'MuPDF':
    i3name = f'[{mupdfRe.search(i3name).group(3)}] {mupdfRe.search(i3name).group(1)}'

# >> use glyph categories for some classes; DICT
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

# >> some special cases
if i3name == 'dropdown':
    i3name = 'tmux'

# >> remove some unnecesary info 
removeRe = re.compile(r' - qutebrowser|sxiv -|feh|^Firefox ')
if removeRe.search(i3name):
    i3name = re.sub(removeRe, '', i3name)

# >> shorten window name
if len(i3name) > 50:
    i3name=i3name[0:50] + "..."

# >> RETURN string for i3blocks 
print(f"<span weight='bold'>{i3class}  {i3name}</span>")
#print(f"<span weight='bold'>{i3name}</span>")

