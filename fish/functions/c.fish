function c -d "copy chosen/arg files to destination from fzf"
    if test (string length "$argv[1]") -gt 0
        for arg in $argv
            set files $files "$arg"
        end
    else
        set files (fd -t f . | fzf -m --header='Choose files to copy')
    end
    set dest (fd -t d -H -d 5 . $HOME \
    | fzf --header='Choose destination')
    set count 0
    if test -d "$dest"
        for file in $files
            cp $file -t $dest
            set count (math $count +1)
        end
        set dest (echo $dest | sed 's|/home/piotr|~|')
        if test $count = 1
            set suffix ""
        else
            set suffix s
        end
        echo "copied $count file$suffix --> $dest"
    end
end

