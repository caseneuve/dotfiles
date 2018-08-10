#!/bin/env python

# Last update: 11.08.18, 00:33:16 @x200
# >> DOC:
# TODO: make option to name the file 

# >> IMPORT:
import i3ipc, re, os, shelve
from subprocess import getoutput as gout
from subprocess import Popen as pop
from datetime import datetime as dt
from rofi import Rofi

#import psutil
#from subprocess import check_output

# >> VARIABLES: i3
i3 = i3ipc.Connection()
i3info = i3.get_tree().find_classed('MuPDF')
i3ws = i3.get_tree().find_focused().workspace().num

# >> VARIABLES: cacheDir
cacheDir = '/home/piotr/.cache/mupdf-cache'

# >> VARIABLES: rofi theme
r = Rofi(rofi_args=['-theme', '/home/piotr/.config/rofi/mytheme.rasi'])

# >> FUNCTIONS
# >> 0. HELPER: NOTIFY
def notify(urgency, message):
    pop(['notify-send', '-u', urgency, 'MuPDF cache:', message])
    return

# >> A. MUPDF CACHE
def mupdf_cache():
    # >> a0. go to the working directory!
    os.chdir(cacheDir)

    # >> a1. get TITLE, PAGE and DPI
    tpdRe = re.compile(r'([\[\]\(\)a-z0-9-_.ąćęłńóźż ]*.pdf) - ([0-9]*)/[0-9]* \(([0-9]*) dpi\)', re.I)

    # >> a2. APPEND title, page and dpi values to the list
    tpdList = [tpdRe.search(title.name).groups() for title in i3info]

    # >> a3. make PATH, PAGE, DPI list
    allArgsList = []
    pdfFiles = gout(['find /home/piotr -name "*.pdf"']).split('\n')
    for el in tpdList:
        for path in pdfFiles:
            if str(el[0]) in path:
                allArgsList.append((path, int(el[1]), int(el[2])))
                break # note: the fist match is enough (without break, we'd have duplicates if they exist on drive)
        
    # >> a4. ask for the name of cached file
    indexN, keyN = r.select("do you want to name the cached file? [y/n]", ['yes', 'no'])
    if indexN == 0:
        nameFile = r.text_entry("enter the name:")
        cacheFile = dt.now().strftime(f'%y%m %d %b @%H:%M:%S {nameFile} ({len(allArgsList)})')
    elif keyN == -1:
        quit()
    else:
        cacheFile = dt.now().strftime(f'%y%m %d %b @%H:%M:%S ({len(allArgsList)})')

    # >> a5. save the FINAL LIST in cacheDir
    shelfFile = shelve.open(cacheFile)
    shelfFile['mupdfList'] = allArgsList
    shelfFile.close()

    # >> a6. notify about the cached file
    notify('low', f'File "{cacheFile}" saved')

# >> B. MUPDF LOAD
def mupdf_load():
    # >> b1. goto cache dir and get the list of files
    os.chdir(cacheDir)
    cachedFiles = os.listdir()
    if cachedFiles == []:
        notify('normal', 'No pdf files cached')
        quit()

    # >> b2. sort them
    cachedFiles.sort(reverse=True)

    # >> b2.0 choose file to load
    indexB, keyB = r.select('choose a list to load:', cachedFiles)
    if keyB == -1:
        quit()
    else:
        loadFile = cachedFiles[indexB]

    # >> b2.1 load the most recent file [OFF]
    #loadFile = cacheFiles[0]
    
    # >> b3. load mupdfChosenList from the chosen file
    shelfFile = shelve.open(loadFile)
    mupdfChosenList = shelfFile['mupdfList']

    # >> b4. run mupdf
    for el in mupdfChosenList:
        if os.path.exists(el[0]):
            pop(['mupdf', '-r', f'{int(el[2])}', f'{el[0]}', f'{el[1]}'])
        else:
            notify('critical', f'File "{el[0]}" no longer exists')

    # >> b5. make sure i3 layout will be tabbed
    if i3ws == 5:
        i3.command('workspace 5; layout tabbed')

# >> C. EXECUTE

if i3info == []:
    mupdf_load()
else:
    optsA = ['[1] load', '[2] cache']
    indexA, keyA = r.select('MuPDF cache action:', optsA)
    if keyA == -1:
        quit()
    elif indexA == 0:
        mupdf_load()
    else:
        mupdf_cache()



##########################################################################
# >> X. SPADY:
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

