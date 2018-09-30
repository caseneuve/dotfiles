#!/bin/env python

# Last update: 30.09.18, 23:30:57 @x200
# >> DOC: 

# >> TODOS
# done: [x] check if cache dir exists and create it when not, 30/09/2018
# fixme: [ ] mupdf_cache func is soooo slow, what is the reason?

# >> IMPORT
import i3ipc
import re
import os
import shelve
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

# >> VARIABLES: cache_dir
cache_dir = '/home/piotr/.cache/mupdf-cache'

# >> VARIABLES: rofi theme
r = Rofi(rofi_args=['-theme', '/home/piotr/.config/rofi/mytheme.rasi'])

# >> FUNCTIONS
# >> 0. HELPER: NOTIFY
def notify(urgency, message):
    pop(['notify-send', '-u', urgency, 'MuPDF cache:', message])
    return

# >> A. MUPDF CACHE
def mupdf_cache():
    # >> a0. check if cache_dir exists, create if not, and go there
    if not os.path.isdir(cache_dir):
        os.mkdir(cache_dir)
    os.chdir(cache_dir)

    # >> a1. get TITLE, PAGE and DPI
    tpd_re = re.compile(r'([\[\]\(\)a-z0-9-_.ąćęłńóśźż ]*.pdf) - ([0-9]*)/[0-9]* \(([0-9]*) dpi\)', re.I)

    # >> a2. APPEND title, page and dpi values to the list
    tpd_list = [tpd_re.search(title.name).groups() for title in i3info]

    # >> a3. make PATH, PAGE, DPI list
    all_args_list = []
    pdf_files = gout(['find /home/piotr -name "*.pdf"']).split('\n')
    for el in tpd_list:
        for path in pdf_files:
            if str(el[0]) in path:
                all_args_list.append((path, int(el[1]), int(el[2])))
                break # note: the fist match is enough (without break, we'd have duplicates if they exist on disc)
        
    # >> a4. ask for the name of cached file
    index_n, keyN = r.select("do you want to name the cached file? [y/n]", ['yes', 'no'])
    if index_n == 0:
        name_file = r.text_entry("enter the name:")
        cache_file = dt.now().strftime(f'%y%m %d %b @%H:%M:%S {name_file} ({len(all_args_list)})')
    elif keyN == -1:
        quit()
    else:
        cache_file = dt.now().strftime(f'%y%m %d %b @%H:%M:%S ({len(all_args_list)})')

    # >> a5. save the FINAL LIST in cache_dir
    shelf_file = shelve.open(cache_file)
    shelf_file['mupdfList'] = all_args_list
    shelf_file.close()

    # >> a6. notify about the cached file
    notify('low', f'File "{cache_file}" saved')

# >> B. MUPDF LOAD
def mupdf_load():
    # >> b1. goto cache dir and get the list of files
    os.chdir(cache_dir)
    cached_files = os.listdir()
    if cached_files == []:
        notify('normal', 'No pdf files cached')
        quit()

    # >> b2. sort them
    cached_files.sort(reverse=True)

    # >> b2.0 choose file to load
    index_b, key_b = r.select('choose a list to load:', cached_files)
    if key_b == -1:
        quit()
    else:
        load_file = cached_files[index_b]

    # >> b2.1 load the most recent file [OFF]
    #load_file = cacheFiles[0]
    
    # >> b3. load mupdf_chosen_list from the chosen file
    shelf_file = shelve.open(load_file)
    mupdf_chosen_list = shelf_file['mupdfList']

    # >> b4. run mupdf
    for el in mupdf_chosen_list:
        if os.path.exists(el[0]):
            pop(['mupdf', '-r', f'{int(el[2])}', f'{el[0]}', f'{el[1]}'])
        else:
            notify('critical', f'File "{el[0]}" no longer exists')

    # >> b5. make sure i3 layout will be tabbed
    if i3ws == 5:
        i3.command('workspace 5; layout tabbed')

# >> C. OPEN PDF from default folder ~/pdf
def mupdf_open():
    pdf_folder = '/home/piotr/pdf'
    os.chdir(pdf_folder)
    pdfs = os.listdir()
    index_o, key_o = r.select('choose a file to open:', pdfs)
    if key_o == -1:
        quit()
    else:
        pop(['mupdf', f'{pdfs[index_o]}'])

# >> D. EXECUTE

if i3info == []:
    opts0 = ['[1] load', '[2] open pdf']
    index0, key0 = r.select('MuPDF cache action:', opts0)
    if key0 == -1:
        quit()
    elif index0 == 0:
        mupdf_load()
    else:
        mupdf_open()
else:
    opts_a = ['[1] load', '[2] open pdf', '[3] cache']
    index_a, key_a = r.select('MuPDF cache action:', opts_a)
    if key_a == -1:
        quit()
    elif index_a == 0:
        mupdf_load()
    elif index_a == 1:
        mupdf_open()
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

