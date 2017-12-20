#!/bin/bash

jpg1=$1

cp "$jpg1" ~/.i3/wall.jpg && \
feh --bg-fill ~/.i3/wall.jpg
