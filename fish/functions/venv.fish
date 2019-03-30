function venv -d 'create, activate or deactivate python virtualenv'
    set VENV_DIR "$HOME/.virtualenvs"
    switch $argv[1]
        case new
            set path "$VENV_DIR/$argv[2]"
            if test -d "$path"
                echo "Venv already set up!"
            else
                echo "Setting up venv..."
                python3 -m venv $path \
                && echo "Virtual env created at $path"
            end
        case req
            if test $VIRTUAL_ENV
                if test $argv[2]
                    set reqs "$argv[2]"
                else
                    set reqs "requirements.txt"
                end
                pip install -r "$reqs"
            else
                echo -e "Venv not active.\nType `venv [name]` to activate it."
            end
        case d deactivate
            if test $VIRTUAL_ENV
                deactivate
            else
                echo "Venv not active."
            end
        case list
            for dir in (ls $VENV_DIR)
                echo "$dir"
            end
        case '*'
            set path "$VENV_DIR/$argv[1]"
            if test -d "$path"
                source $path/bin/activate.fish
            else
                echo -e "Venv $argv[1] doesn't exist.\nType: `venv new $argv[1]` to set it up."
            end
    end

end
