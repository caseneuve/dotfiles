function d -d "delete chosen files from fzf"
    set files (fd -t f . | fzf -m --header='!!! Choose files to delete !!!')
    set count 0
    for file in $files
        rm $file
        set count (math $count +1)
    end
    if test $count -gt 1
        set suffix s
    else
        set suffix ""
    end
    echo "deleted $count file$suffix!"
end

