function m -d "move chosen/arg files to destination from fzf"
    if test (string length "$argv[1]") -gt 0
        for arg in $argv
            set files $files "$arg"
        end
    else
        set files (
        fd -t f . | fzf -m --header='Choose files to move'
        )
    end
    set dest (
    fd -H -t d -d 5 . $HOME | fzf --header='Choose destination'
    )
    if test -d "$dest"
        set count 0
        for file in $files
            mv $file -t $dest
            set count (math $count +1)
        end
        set dest (echo $dest | sed 's|/home/piotr|~|')
        if test $count = 1
            set suffix ""
        else
            set suffix s
        end
        echo "moved $count file$suffix --> $dest"
    end
end
