function venv -d 'create, activate or deactivate python virtualenv'
    set VENV_DIR "$HOME/.virtualenvs"
    switch $argv[1]
        case -n --new
            set path "$VENV_DIR/$argv[2]"
            if test -d "$path"
                echo "Venv already set up!"
            else
                echo "Setting up venv..."
                python3 -m venv $path \
                && echo "Virtual env created in $path"
                source $path/bin/activate.fish
            end
        case -r --requirements
            if test $VIRTUAL_ENV
                if test $argv[2]
                    set reqs "$argv[2]"
                else
                    set reqs "requirements.txt"
                end
                pip install -r "$reqs"
            else
                echo -e "Venv not active.\nType `venv -a [name]` to activate it."
            end
        case -d --deactivate
            if test $VIRTUAL_ENV
                deactivate
            else
                echo "Venv not active."
            end
        case -l --list
            for dir in (ls $VENV_DIR) (fd -H -p ".*/bin/python\$" -d 3 | sed "s|/.*||g")
                echo "$dir"
            end
        case -a --activate
            #set path "$VENV_DIR/$argv[2]"
            if test -d "$VENV_DIR/$argv[2]"
                set path "$VENV_DIR/$argv[2]/bin"
            else
                set path "$argv[2]/bin"
            end

            if test -d "$path"
                source $path/activate.fish
            else
                echo -e "Venv '$argv[2]' does not exist.\nType `venv -n $argv[2]` if you want to set it up."
            end
        case -s --search
            if test -z $argv[2]
                set level 3
            else
                set level $argv[2]
            end
            fd -H -p ".*/bin/python\$" -d $level
    end
end

function venv_complete -d 'completions for venv'
    fd . ~/.virtualenvs -t d -d 1 | sed "s|.*/||g"
    fd -H -p ".*/bin/python\$" -d 3 | sed "s|/.*||g"
end

complete -c venv -s r -l requirements -x -a '(fd -e txt .)' -d 'install requirements'
complete -c venv -s n -l new -x -a '(basename (pwd))' -d 'new venv'
complete -c venv -s l -l list -x -d 'list venvs'
complete -c venv -s d -l deactivate -x -d 'deactivate current venv'
complete -c venv -s a -l activate -x -a '(venv_complete)' -d 'activate venv'
complete -c venv -s s -l search -x -d 'search for venvs in this directory'
