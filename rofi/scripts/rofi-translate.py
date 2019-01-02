#!/bin/python

# Path:        ~/biu/py/rofi-translate.py
# Created:     13.08.18, 18:10    @x200
# Last update: 01.01.19, 19:41:23 @lenovo

# >> DOC:
# note: requires translate-shell, rofi, python-rofi
# usage: enter query → [expression to translate] &opt <[from_lang] >[to_lang]
# example: "casa <es >en" or "casa >en <es"

# >> TODOs:
# todo: niech zapisuje wyniki w osobistym słowniku [((słowo, znaczenie), <ile razy>)]
# done: dodać możliwość zmiany języka np \fra → będzie wyszukiwał dla języka francuskiego
# done: warunek dla złych wpisów (np. liczby)
# done: warunek: jeśli query = resp niech daje komunikat, że nie znalazł tłumaczenia

# >> LIBS
import sys
from subprocess import check_output as out
from subprocess import Popen as pop
import re
from rofi import Rofi

# >> VARIABLES
#r = Rofi(rofi_args=['-theme', '/home/piotr/.config/rofi/mytheme.rasi'])
try:
    theme = '/home/piotr/.config/rofi/' + str(sys.argv[1])
except IndexError:
    theme = '/home/piotr/.config/rofi/mytheme.rasi'
try:
    monitor = str(sys.argv[2])
except IndexError:
    monitor = '-2'
r = Rofi(rofi_args=['-theme', theme, '-monitor', monitor])

unbashify_re = re.compile(r'\x1b\[(1m|22m|24m|4m)')
kill_head_re = re.compile(
    r'^.*\n.*\n*.*\n*.*\n\[ (.*) -> (.*) \]\n*', re.UNICODE)
to_lang_re = re.compile(r' \>([a-z]*)')
from_lang_re = re.compile(r' \<([a-z]*)')

# >> QUERY
def validator(s): return (s, None) if not any(char.isdigit()
                                              for char in s) else (None, ' ')

query = r.generic_entry('  TRANSLATE: ', validator)

# >> REGEX OPS
if query == None:
    quit()
else:
    to_lang = to_lang_re.search(query)
    from_lang = from_lang_re.search(query)
    if to_lang != None:
        to_lang = to_lang.group(1)
        query = re.sub(to_lang_re, '', query)
    else:
        to_lang = ''
    if from_lang != None:
        from_lang = from_lang.group(1)
        query = re.sub(from_lang_re, '', query)
    else:
        from_lang = ''
    resp = out(['trans', f'{from_lang}:{to_lang}',
                f'{query}']).decode('utf-8').rstrip()
    unbash = re.sub(unbashify_re, '', resp)
    del_head = kill_head_re.search(unbash)
    if del_head != None:
        from_lang, to_lang = kill_head_re.search(unbash).groups()
    else:
        from_lang = '?'
        to_lang = '?'
    defs = re.sub(kill_head_re, '', unbash)
    defs = re.sub(r'    ', r'- ', defs)
    defs = re.sub(r'\n- - ', r' : ', defs)

# >> OUTPUT
if resp != query:
    pop(['notify-send', '-u', 'low',
         f'{query} ({from_lang} → {to_lang}):\n----------', f'{defs}'])
else:
    pop(['notify-send', '-u', 'low', 'Translate:\n----------',
         f'Nie znaleziono tłumaczenia dla <b>{query}</b>.'])
