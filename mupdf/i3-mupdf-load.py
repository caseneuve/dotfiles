#!/bin/env python

# Path:        ~/biu/py/i3-mupdf-load.py
# Created:     08.08.18, 22:38    @x200
# Last update: 09.08.18, 11:32:27 @x200

# >> DOC: load cached pdfs from ~/.cache/mupdf-cache files
# TODO: jak py może przyjmować argumenty z zewnątrz? (note: idea jest taka, żeby pliki można było wybierać via rofi; ten skrypt ma czytać wybrany plik) | 08/08/2018
# >> NOTE: na razie posortujemy i wybierzemy ostatni plik

import shelve, os, i3ipc
from subprocess import Popen as pop

# >> VARIABLES
i3 = i3ipc.Connection()
i3ws = i3.get_tree().find_focused().workspace().num
cacheDir = '/home/piotr/.cache/mupdf-cache'

# >> 1. goto cache dir
os.chdir(cacheDir)

# >> 2. get the list of files and sort them
cacheFiles = os.listdir()
cacheFiles.sort(reverse=True)
loadFile = cacheFiles[0]

# >> 3. load cacheList from the chosen file
shelfFile = shelve.open(loadFile)
cacheList = shelfFile['cacheList']

# >> 4. run mupdf
# BUG: odpala po jednym procesie i czeka aż ten zostanie zamknięty
for el in cacheList:
    pop(['mupdf', f'{el[0]}', f'{el[1]}'])

# >> 5. make sure i3 layout will be tabbed
if i3ws == 5:
    i3.command('workspace 5; layout tabbed')

