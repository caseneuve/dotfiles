function l -d "link chosen files to destination from fzf"
    set dir (pwd)
    set files (fd -t f . | fzf -m --header='Choose files to link')
    if test -n "$files"
        set dest (fd -H -t d -d 5 . $HOME \
        | fzf --header='Choose destination')
        if test -d "$dest"
            set count 0
            for file in $files
                ln -s $dir/$file -t $dest
                set count (math $count +1)
            end
            set dest (echo $dest | sed 's|/home/piotr|~|')
            if test $count = 1
                set suffix ""
            else
                set suffix s
            end
            echo "linked $count file$suffix --> $dest"
        end
    end
end

