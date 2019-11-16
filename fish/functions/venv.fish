function venv -d 'create, activate or deactivate python virtualenv'
    set VENV_DIR "$HOME/.virtualenvs"
    switch $argv[1]
        case -n --new
            if test -z $argv[3]; set path "$VENV_DIR/$argv[2]"
            else;                set path "$argv[2]"
            end
            if test -d "$path"
                printf "Venv already set up! Activating instead."
                source $path/bin/activate.fish
            else
                printf "Setting up venv..."
                python3 -m venv $path \
                && printf "Virtual env created in $path" \
                && source $path/bin/activate.fish
            end
        case -r --requirements
            if test $VIRTUAL_ENV
                pip install -U pip
                if test $argv[2]; set reqs "$argv[2]"
                else;             set reqs "requirements.txt"
                end
                pip install -r "$reqs"
            else; printf "Venv not active.\nType `venv -a [name]` to activate it."
            end
        case -d --deactivate
            if test $VIRTUAL_ENV
                source "$VIRTUAL_ENV/bin/activate.fish"
                deactivate
            else; printf "Venv not active."
            end
        case -l --list
            for dir in (ls $VENV_DIR) (fd -H -p ".*/bin/python\$" -d 3 | sed "s|/.*||g")
                printf "$dir"
            end
        case -a --activate
            if test -d "$VENV_DIR/$argv[2]"; set path "$VENV_DIR/$argv[2]/bin"
            else;                            set path "$argv[2]/bin"
            end

            if test -d "$path"; source $path/activate.fish
            else
                printf "Venv '%s' does not exist.\nType `venv -n %s` if you want to set it up." \
                $argv[2] $argv[2]
            end
        case -s --search
            if test -z $argv[2]; set level 3
            else;                set level (math 3 + $argv[2])
            end
            set venvs (fd -H -p ".*/bin/python\$" -d $level)
            if test -z "$venvs"
                printf "No virtual environments found while digging up to level %d" \
                (math $level - 2)
            else
                printf "Python virtual environments under this location (digging to level %s)\n %s\n" \
                (math $level - 2) \
                (string split " " (echo $venvs | sed "s|/bin/python||g"))
            end
    end
end

function venv_complete -d 'completions for venv'
    fd . ~/.virtualenvs -t d -d 1 | sed "s|.*/||g"
    fd -H -p ".*/bin/python\$" -d 3 | sed "s|/.*||g"
end

complete -c venv -s r -l requirements -x -a '(fd -e txt .)'    -d 'install requirements [from FILE]'
complete -c venv -s n -l new -x -a          '(basename (pwd))' -d 'new venv NAME [LOCALLY]'
complete -c venv -s l -l list -x -d         'list venvs'
complete -c venv -s d -l deactivate -x -d   'deactivate current venv'
complete -c venv -s a -l activate -x -a     '(venv_complete)'  -d 'activate venv'
complete -c venv -s s -l search -x -d       'search for venvs in this directory [DEPTH]'
