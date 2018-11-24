#!/bin/bash
# Last update: 24.11.18, 08:36:59 @x200

# DOC:
# zmienia opacity dla bieżącego okna, skrypt za Luke Smith
# https://www.youtube.com/watch?v=Ja-DgvGPDu8
# zmieniłem ostani wiersz, żeby wracał do ustawionej w comptonie opacity

transset-df -a -m 0
sleep .1
transset-df -a -x 1
sleep .1
transset-df -a -m 0
sleep .1
transset-df -a -m 0.85

