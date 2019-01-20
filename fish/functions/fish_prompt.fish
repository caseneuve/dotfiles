function fish_prompt -d "My fish prompt"
    set -l STAT $status
    set -l PPWD (prompt_pwd)
    # virtyal env
    # if set -q VIRTUAL_ENV
    #     echo -n -s (set_color magenta) "{" (basename "$VIRTUAL_ENV") "}" (set_color normal) " "
    # end
    set_color -o white
    echo -n (string replace -r "~/" "" -- $PPWD)
    set_color normal
    if test $STAT = 0
        set_color green
        echo -n ': ' 
    else
        set_color red
        echo -n ': ' 
    end
    set_color normal
end
