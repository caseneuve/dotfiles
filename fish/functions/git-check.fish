function git-check -d "check git status for some projects"
    set -l CWD (pwd)
    # parse args
    set -l options (fish_opt -s e -l exclude --required-val)
    set options    (fish_opt -s v -l verbose --optional-val) $options
    set options    (fish_opt -s s -l short --optional-val) $options
    set options    (fish_opt -s h -l help --optional-val) $options
    
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

    set found false
    set long true
    set excluded
    set counter 0
    set clean 0
    
    if set -q _flag_short; set long false; end
    if set -q _flag_exclude; set excluded (string replace -a "," "|" "$_flag_exclude"); end
    
    function porcelain -S
        set -l this (string replace $HOME "~" (pwd))
        set -l porcelain (git status --porcelain 2>/dev/null)
        if test $status -ne 0
            if set -q _flag_verbose
                if $long; printf "\n!! Not git repo: $this\n" 
                else;     printf " [!!] $this *is not a git repo*\n" 
                end
            else
                if $long; echo -n "#"; end
            end
            
            return
        end

        if test -n "$porcelain"
            set found true 
            if ! $long
                printf " [%2s] $this \n" \
                (git status --porcelain 2>/dev/null | wc -l)
            else
                printf "\n\n%s$this%s\n" (set_color -ou white) (set_color normal)
                set porcelain (string replace -a "D  " " D " "$porcelain")
                set porcelain (string replace -a "  "  "\n " "$porcelain")
                set porcelain (string replace -a " ?"  "\n " "$porcelain")
                printf "$porcelain\n"
            end
        else
            # if not set -q _flag_short; printf . ; end
            if $long; printf . ; end
            set clean (math $clean + 1)
        end
    end

    # printf "%sGIT CHECK%s\n" (set_color -o white) (set_color normal)
    # figlet -f mini "GIT CHECK"

    for dir in $HOME/git/* $HOME/web/schole
        builtin cd $dir
        for project in (ls)
            if test -d $project
                if test (string match -r "$excluded" "$project"); continue; end
                builtin cd $project; porcelain; builtin cd ..
                set counter (math $counter + 1)
            end
        end
    end

    # treat .dotfiles as special to avoid checking all subdirectories
    builtin cd $HOME/.dotfiles
    if test ! (string match -r "$excluded" "$PWD")
        porcelain
        set found true
        set counter (math $counter + 1)
    end

    # print closing message
    if $long; printf "\n"; end
    if test $counter -eq $clean; set clean all; end
    printf "Checked %s%s%s repositories, %s%s%s clean" \
    (set_color -o brred) \
    $counter \
    (set_color normal) \
    (set_color -o yellow) \
    $clean \
    (set_color normal)

    # return to where started
    builtin cd $CWD
    
end
