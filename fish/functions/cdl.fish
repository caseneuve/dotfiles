function cdl -d "cd and ls"
    if test -d $argv[1]
        cd $argv[1]
    end
    ls --group-directories-first
end
