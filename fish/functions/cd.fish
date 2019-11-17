function cd -d "Change dir and list contents; if no path specified, go to previous dir in history"
    if test -d "$argv[1]"; builtin cd "$argv[1]"
    else; prevd
    end
    ls --group-directories-first
end
