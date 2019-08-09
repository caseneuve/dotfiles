function git-check -d "check git status for some projects"
    # parse args
    set -l options (fish_opt -s e -l exclude --required-val)
    set options (fish_opt -s v -l verbose --optional-val) $options
    set options (fish_opt -s s -l short --optional-val) $options

    argparse -n git-check $options -- $argv
    if test $status -ne 0; return 1; end

    set -g verbose false
    set -g long true
    
    if set -q _flag_verbose
        set -g verbose true
    end

    if set -q _flag_short
        set -g long false
    end
    
    function porcelain
        set -l porcelain (git status --porcelain 2>/dev/null)

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
            set -l this (string replace $HOME/ "~/" (pwd))
            if $long
                printf "\n\n$this\n"
                set porcelain (string replace -a "D  " " D " "$porcelain")
                set porcelain (string replace -a "  " "\n " "$porcelain")
                set porcelain (string replace -a " ?" "\n " "$porcelain")
                printf "$porcelain\n"
            else
                printf " [%2s] $this \n" (git status --porcelain 2>/dev/null | wc -l)
            end
        else
            if $long
                printf .
            end
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

    # echo

    # cleanup global var
    set -e verbose
    set -e long
end



