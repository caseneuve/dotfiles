function git-check -d "check git status for some projects"
    # check args for -e flag
    set -l options (fish_opt -s e -l exclude --required-val)
    argparse -n git-check $options -- $argv
    if test $status -ne 0; return 1; end

    function porcelain
        set -l porcelain (git sp)
        if test -n "$porcelain"
            string replace $HOME/ "" (pwd)
            set porcelain (string replace -a "  " "\n " "$porcelain")
            set porcelain (string replace -a " ?" "\n " "$porcelain")
            echo -e "$porcelain"
            echo
        end
    end

    echo CHECKING GIT STATUS FOR CHOSEN REPOS
    echo ------------------------------------

    for dir in $HOME/git/lab $HOME/git/hub $HOME/web/schole
        cd $dir
        for project in (ls)
            if test -d $project
                # if project was excluded, continue
                if set -q _flag_exclude
                    set -l excluded (string replace -a "," "\|" "$_flag_exclude")
                    if echo $project | grep "$excluded" >/dev/null
                        continue
                    end
                end
                # else: print git status porcelain info
                cd $project
                porcelain
                cd ..
            end
        end
    end

    cd $HOME/.dotfiles
    porcelain

    echo ------------------------------------
    echo ...DONE!

end



