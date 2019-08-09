function git-check -d "check git status for some projects"
    # parse args
    set -l options (fish_opt -s e -l exclude --required-val)
    set options (fish_opt -s v -l verbose --optional-val) $options
    set options (fish_opt -s s -l short --optional-val) $options
    set options (fish_opt -s h -l help --optional-val) $options
    
    argparse -n git-check $options -- $argv
    if test $status -ne 0; return 1; end

    if set -q _flag_help
        printf "Usage: git-check [-h] [-s] [-v] [-e <str>]\n
Check git status for some repos.\n
Options:
 -e/--exclude STR  exclude directory matching STR
 -h/--help         print this message and quit
 -s/--short        print short output, otherwise print full 
                   `git status --porcelain` info
 -v/--verbose      if not git repos found, output them, 
                   otherwise print "\'\#\'"
"
        return
    end

    set long true
    if set -q _flag_short; set long false; end
    
    function porcelain -S
        set -l this (string replace $HOME "~" (pwd))

        set -l porcelain (git status --porcelain 2>/dev/null)
        if test $status -ne 0
            if set -q _flag_verbose
                if $long
                    printf "\n!! Not git repo: $this\n" 
                else
                    printf " [!!] $this * is not a git repo *\n" 
                end
            else
                if $long; echo -n "#"; end
            end
            
            return
        end

        if test -n "$porcelain"
            if set -q _flag_short
                printf " [%2s] $this \n" \
                (git status --porcelain 2>/dev/null | wc -l)
            else
                printf "\n\n$this\n"
                set porcelain (string replace -a "D  " " D " "$porcelain")
                set porcelain (string replace -a "  " "\n " "$porcelain")
                set porcelain (string replace -a " ?" "\n " "$porcelain")
                printf "$porcelain\n"
            end
        else
            if not set -q _flag_short
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



