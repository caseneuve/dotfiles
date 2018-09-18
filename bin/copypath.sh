#!/bin/bash

# Path:        ~/scr/copypath.sh
# Created:     18.09.18, 07:38    @x200
# Last update: 18.09.18, 07:48:29 @x200

# >> DOC: 

# >> TODOS: 

# >> VARIABLES: 

# >> RUN:

echo $PWD/$1 | xclip -selection clipboard && notify-send -u low "ranger" "path to
<i>$1</i>
copied to clipboard"
