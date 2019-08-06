function git-check -d "check git status for some projects"
    # parse args
    set -l options (fish_opt -s e -l exclude --required-val)
    set options (fish_opt -s v -l verbose --optional-val) $options

    argparse -n git-check $options -- $argv
    if test $status -ne 0; return 1; end

    if set -q _flag_verbose
        set -g verbose true
    else
        set -g verbose false
    end
    
    function porcelain
        set -l porcelain (git sp 2>/dev/null)

        if test $status -ne 0
            if $verbose
                set -l failed (string replace $HOME "~" (pwd))
                printf "\n!! Not git repo: $failed\n"
            else
                echo -n "#"
            end
            
            return
        end
        
        if test -n "$porcelain"
            printf "\n\n"
            string replace $HOME/ "~/" (pwd)
            set porcelain (string replace -a "D  " " D " "$porcelain")
            set porcelain (string replace -a "  " "\n " "$porcelain")
            set porcelain (string replace -a " ?" "\n " "$porcelain")
            printf "$porcelain\n"
        else
            printf .
        end
    end

    echo "Checking git status for chosen repos:"

    for dir in $HOME/git/* $HOME/web/schole
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

    echo

    # cleanup global var
    set -e verbose
end



