function fish_title -d "Title for the terminal window: display last command"
    printf "%s (%s)" (basename (history | sed 1q)) (date '+%H:%M:%S')
end
