#!/bin/python

# Path:        ~/biu/py/rofi-translate.py
# Created:     13.08.18, 18:10    @x200
# Last update: 13.08.18, 21:48:31 @x200

# >> DOC:
# note: requires translate-shell, rofi, python-rofi

# >> TODOs: 
# done: warunek dla złych wpisów (np. liczby)
# todo: niech zapisuje wyniki w osobistym słowniku [((słowo, znaczenie), <ile razy>)]
# done: warunek: jeśli query = resp niech daje komunikat, że nie znalazł tłumaczenia

# >> LIBS
from rofi import Rofi
from subprocess import check_output as out
from subprocess import Popen as pop
import re

# >> VARIABLES
r = Rofi(rofi_args=['-theme', '/home/piotr/.config/rofi/mytheme.rasi'])
unbashify_re = re.compile(r'\x1b\[(1m|22m|24m|4m)')
kill_head_re = re.compile(r'^.*\n.*\n*.*\n*.*\n\[ (.*) -> Polski \]\n*', re.UNICODE)

# >> QUERY
validator = lambda s: (s, None) if not any(char.isdigit() for char in s) else (None, ' ')
query = r.generic_entry('translate: ', validator)

# >> REGEX OPS
if query == None:
    quit()
else:
    resp = out(['trans', f'{query}']).decode('utf-8').rstrip()
    unbash = re.sub(unbashify_re, '', resp)
    dictio = kill_head_re.search(unbash).group(1) 
    defs = re.sub(kill_head_re, '',     unbash)
    defs = re.sub(r'    ',      r'- ',  defs)
    defs = re.sub(r'\n- - ',    r' : ', defs)

# >> OUTPUT
if resp != query:
    pop(['notify-send', '-u', 'low', f'{query} ({dictio}):\n----------', f'{defs}'])
else:
    pop(['notify-send', '-u', 'low', 'Translate:\n----------', f'Nie znaleziono tłumaczenia dla <b>{query}</b>.'])

