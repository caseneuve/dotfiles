function git-check -d "check git status for some projects"
    for dir in $HOME/git/lab $HOME/git/hub $HOME/web/schole
        cd $dir
        for project in (ls)
            if test -d $project
                cd $project
                set -l porcelain (git sp)
                if test "$porcelain" != ""
                    string replace $HOME/ "" (pwd)
                    set -l porcelain (string replace -a "  " "\n " "$porcelain")
                    set -l porcelain (string replace -a " ?" "\n " "$porcelain")
                    echo -e "$porcelain"
                    echo
                end
                cd ..
            end
        end
    end
end



