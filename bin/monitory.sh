#!/bin/bash

# skrypt sprawdza, czy podlaczone sa 2 moniotory, jesli tak, ustawia VGA1 po lewej, a wbudowany jako prawy; jesli nie - ustawia

if [ "$(xrandr --screen 0 | grep -i 'vga1 connected')" ]
then
    xrandr --output eDP1 --auto --output VGA1 --auto --left-of eDP1
else
    xrandr --output eDP1 --auto --output VGA1 --off
fi 
