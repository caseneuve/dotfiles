# My fish prompt
# Last update: 20.01.19, 23:23:04 @toshiba

function fish_prompt -d "My fish prompt"
    # >> set vars
    set -l STAT $status
    set -l PPWD (prompt_pwd)

    # >> func: add_icons
    function add_icons -d "Return appropriate symbol if $CWD is a special context"
        set -l dir "$PWD"
        set_color normal
        if test (string match -a "/home/piotr" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -r "/org" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -ir "/.conf" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -ir "/szk" "$dir")
            echo (set_color  white)"  "(set_color normal)
        else if test (string match -ir "/wiki" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -ir "/\.virtualenvs" "$dir")
            echo (set_color white)" "(set_color normal)
        else if test (string match -r "box/Dropbox" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -r "/dwl" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -r "git/lab" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -r "git/hub" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (git rev-parse --git-dir 2> /dev/null)
            echo (set_color white)" "(set_color normal)
        else if test (string match -r "/pdf" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -r "/wid" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -r "/muz" "$dir")
            echo (set_color white)"  "(set_color normal)
        else if test (string match -r "/obr" "$dir")
            echo (set_color white)"  "(set_color normal)
        end
    end

    # >> virtual env
    if set -q VIRTUAL_ENV
        echo -n -s (set_color magenta) "{" (basename "$VIRTUAL_ENV") "}" (set_color normal) " "
    end

    # >> funcall: add icons
    echo -n (add_icons)

    # >> print CWD with status indicator
    set_color -o white
    echo -n (string replace -r "~/" "" -- $PPWD)
    set_color normal
    if test $STAT = 0
        set_color -o green
        echo -n ': ' 
    else
        set_color -o red
        echo -n ': ' 
    end
    set_color normal
end

