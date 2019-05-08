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
                && echo "Virtual env created at $path"
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
            for dir in (ls $VENV_DIR)
                echo "$dir"
            end
        case -a --activate
            set path "$VENV_DIR/$argv[2]"
            if test -d "$path"
                source $path/bin/activate.fish
            else
                echo -e "Venv '$argv[2]' doesn't exist.\nType: `venv -n $argv[2]` to set it up."
            end
    end

end

complete -c venv -s r -l requirements -x -a '(fd -e txt .)' -d 'install requirements'
complete -c venv -s n -l new -x -a '(basename (pwd))' -d 'new venv'
complete -c venv -s l -l list -x -d 'list venvs'
complete -c venv -s d -l deactivate -x -d 'deactivate current venv'
complete -c venv -s a -l activate -x -a '(ls ~/.virtualenvs)' -d 'activate venv'
