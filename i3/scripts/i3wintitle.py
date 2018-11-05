#!/bin/env python

# Path: ~/.dotfiles/i3/scripts/i3wintitle.py
# Last update: 29.10.18, 21:57:37 @lenovo

# >> DOC:

# >> TODOS:
# >> TODO: clean idiosyncratic names (eg cut out "qutebrowser from qtb etc."):
# - [x] qutebrowser
# - [ ] mpv
# >> TODO: czy da się dostać do tmuxa?; note: tak, ale nie wiem jak updatować skrypt, gdy już się jest w tmuksie
# >> TODO: glyphs


# DONE: gdy zmienia się okno emacsa nie emituje się zmiana sygnału, więc pozostaje pierwszy tytuł (trzeba było dodać `i3.on("window::title", on_window_pkill)` do i3listen.py), note:05/08/2018
# DONE: make a dict {('st': icon), ('emacs': icon)}, NOTE: 05/08/2018, trzeba tylko ściągnąć odpowiednie glify
# DONE: search for key and return icon, else return class, note: 05/08/2018
# DONE: make a script that listens to i3 and responds when window changes focus
# DONE: shorten name, note: 05/08/2018


# >> IMPORTS
#from subprocess import check_output as out
import re
import unicodedata
from subprocess import check_output as out
import i3ipc


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
mupdfRe = re.compile(r'([ąćęńóśżźła-z0-9 ._-]*)(.pdf - )([0-9]+/[0-9]+)', re.I)
if i3class == 'MuPDF':
    i3name = f'[{mupdfRe.search(i3name).group(3)}] {mupdfRe.search(i3name).group(1)}'


# >> Zathura: GET GET PAGE NUMBER FIRST
# note: it won't work if full path is set as the window title!
zathuraRe = re.compile(r'([ąćęńóśżźła-z0-9 \._-]*)(.pdf ).([0-9]+/[0-9]+).', re.I)
if i3class == 'Zathura':
    i3name = f'[{zathuraRe.search(i3name).group(3)}] {zathuraRe.search(i3name).group(1)}'


# >> SENT: find file name
if 'sent' in i3name and 'presenter' in i3class:
    sent_pid = out(['pidof', 'sent']).decode('utf-8').strip()
    i3name = out(['ps', sent_pid]).decode('utf-8').strip().split()[10]


# >> EMACS: EXTRACT ONLY BASENAME
if i3class == 'Emacs':
    if '/' in i3name:
        i3name = out(['basename', i3name]).decode('utf-8').strip()


# >> CLASS ICONS DICT
class_dict = {'Emacs': '',
              'MuPDF': '',
              'Zathura': '*',
              'qutebrowser': '',
              'Firefox': '',
              'Vivaldi-stable': '',
              'st-256color': '',
              'term': '',
              'myquickterm': '',
              'scratch': '',
              'calculator': '',
              'Thunar': '',
              'neomutt': '',
              'mpv': '',
              'Sxiv': '',
              'feh': '',
              'Gimp-2.10': '',
              'MyPaint': '',
              'Slack': '',
              'Messenger for Desktop': '',
              'presenter': '',
              'rss': '',
              'mail': '',
              'calibre': '',
              'whit4ker': '',
              'cl0ck': '',
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
special_dict = {'dropdown': 'tmux',
                'm4ath': 'R calc',
                'w0rds': 'William Whitaker Words'
                }

if i3name in special_dict:
    i3name = special_dict[i3name]


# >> REMOVE SOME UNNECESARY INFO
removeRe = re.compile(
    r' - qutebrowser|sxiv -|feh|^Firefox |^Home \| |\| GitLab|Slack - |- Mozilla Firefox')
if removeRe.search(i3name):
    i3name = re.sub(removeRe, '', i3name)


# >> SHORTEN WINDOW NAME
if len(i3name) > 50:
    i3name = i3name[0:50] + "..."


# >> REPLACE invalid pango characters
pango_escape = {
    "&": "&amp;",
    "<": "&lt;",
}

for i in pango_escape:
    if i in i3name:
        i3name = i3name.replace(i, pango_escape[i])


# >> KILL control characters (invalid in JSON string)
i3name = "".join(ch for ch in i3name if unicodedata.category(ch)[0]!="C")


# >> PRINT result
print(f"<span weight='normal'>{i3class}  {i3name}</span>")

