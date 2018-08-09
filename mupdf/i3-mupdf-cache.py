#!/bin/env python

# Last update: 09.08.18, 11:17:23 @x200
# >> DOC:
# FIXME: uwaga na wyjątki, np. mupdf nie jest włączony
# TODO: how to sort list of lists by the first element of each sublist?

# >> IMPORT:
import i3ipc, re, os, shelve
from subprocess import getoutput as gout
from datetime import datetime as dt
#import psutil
#from subprocess import check_output

# >> VARIABLES: i3
i3 = i3ipc.Connection()
i3info = i3.get_tree().find_classed('MuPDF')

# >> 0. exit script exception
if i3info == []:
    quit()

# >> VARIABLES: cacheDir
cacheDir = '/home/piotr/.cache/mupdf-cache'

# >> 1. get TITLE and PAGE
tpString = re.compile(r'([\[\]\(\)a-z0-9-_.ąćęłńóźż ]*.pdf) - ([0-9]*)/', re.I)

# >> 2. APPEND title and page pairs to the list
tpList = [tpString.search(title.name).groups() for title in i3info]

# >> 3. make PATH / PAGE list
finalList = []
pdfFiles = gout(['find /home/piotr -name "*.pdf"']).split('\n')
for el in tpList:
    for path in pdfFiles:
        if str(el[0]) in path:
            finalList.append((path, el[1]))
            break # note: the fist match is enough (without break, we'd have duplicates if they exist on drive)
        
#print(finalList)

# >> 4. save the FINAL LIST in cacheDir
os.chdir(cacheDir)
cacheFile = 'mu-ca' + dt.now().strftime("%y%m%d_%H%M%S")
shelfFile = shelve.open(cacheFile)
shelfFile['cacheList'] = finalList
shelfFile.close()

# >> SPADY:
# tpList = [ ]
# for title in i3info:
#     tpList.append(tpString.search(title.name).groups())

#print(tpList)

# find full paths of files 
# Path = [ ]
# proc = check_output(["pidof", "mupdf"]).decode().rstrip().split(' ')
# for i in proc:
#     Path.append(psutil.Process(int(i)).open_files()[0][0])

#print(Path)

# associate paths with page numbers; BUG: 
# PathPage = [ ]
# for title in tpList:
#     for path in Path:
#         if str(title[0]) in path:
#             PathPage.append((path, title[1]))
            
#print(PathPage)

# BUG: nie działa, py potrafi znaleźć prawdziwą ścieżkę tylko wtedy, gdy jest w odpowiednim folderze; inaczej łączy cwd z nazwą pliku!
# FIXME: znaleźć funkcję, która szuka ścieżki pliku po naznwie

# NewPP = []
# for el in tpList:
#     NewPP.append((os.path.realpath(str(el[0])), el[1]))

# NOTE: VEEERY SLOW
# for el in tpList:
#     for root, dirs, files in os.walk('/home/piotr'):
#         for file in files:
#             if file.endswith('.pdf'):
#                 if el[0] in file:
#                     #print(root + "/" + el[0])
#                     print(os.path.realpath(os.path.join(root, el[0])))
#                     #print(el[0])

