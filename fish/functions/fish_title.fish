function fish_title -d "Title for the terminal window: display last command"
    if test $VIRTUAL_ENV
        set -l venv (string replace "$HOME/.virtualenvs/" "" $VIRTUAL_ENV)
        printf "(%s) %s %s %s %s" $venv (date '+%H:%M:%S') (pwd) \$ "$argv[1]"
    else
        printf "%s %s %s %s" (date '+%H:%M:%S') (pwd) \$ "$argv[1]"
    end
end
