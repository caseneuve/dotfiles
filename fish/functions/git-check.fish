function git-check -d "check git status for some projects"
    # todo: export this to fish config
    set git_check_groups ~/git/* ~/web/schole
    set git_check_projects ~/.dotfiles

    # remeber where we're starting off
    set -l CWD (pwd)
    #* parse args
    set -l options (fish_opt -s e -l exclude --required-val)
    set options    (fish_opt -s v -l verbose --optional-val) $options
    set options    (fish_opt -s s -l short --optional-val) $options
    set options    (fish_opt -s h -l help --optional-val) $options
    set options    (fish_opt -s p -l project --required-val) $options
    set options    (fish_opt -s g -l groupdirs --required-val) $options

    argparse -n git-check $options -- $argv
    if test $status -ne 0; return 1; end

    #* print usage if help required
    if set -q _flag_help
        printf "Usage: git-check [-h] [-s] [-v] [-e <str>]\n
Check git status for some repos.\n
Options:
 -h/--help         print this message and quit
 -s/--short        print short output, otherwise print full
                   `git status --porcelain` info
 -e/--exclude STR  exclude directory matching STR
 -v/--verbose      if not git repos found, output them,
                   otherwise print "\'\#\'"
 -p/--project      check only git status for given path in \$HOME dir
 -g/--groupdirs    ...
"
        return
    end

    #* set variables
    set found false
    set long true
    set excluded
    set counter 0
    set clean 0
    set skipped 0

    # TODO: add condition to pass if _flag_projects set
    if set -q _flag_project
        printf "Checking only locations passed with -p flag:\n"
    else if set -q _flag_groupdirs
        set git_dirs "$_flag_groupdirs"
    else if set -q git_check_groups
        set git_dirs "$git_check_groups"
    else if set -q git_check_projects
        printf "Checking only projects specified in \$git_check_projects:\n"
    else
        printf "Can't check projects!

Specify \$git_group_dirs environmental variable or pass directories to check
using --groupdirs flag or a single project with a --project flag.

Type git-check -h for more help.
"
        return
    end

    if set -q _flag_short; set long false; end
    if set -q _flag_exclude; set excluded (string replace -a "," "|" "$_flag_exclude"); end

    #* porcelain suite
    #** check porcelain status
    function _check_porcelain_status -S
        if test $status -ne 0
            if set -q _flag_verbose
                if $long; printf "\n%s%s%s %sis not a git repository%s\n" \
                    (set_color -ou red) \
                    "$this" \
                    (set_color normal) \
                    (set_color red) \
                    (set_color normal)
                else; printf " [!!] $this *is not a git repo*\n"
                end
            else
                if $long; printf "%s#%s" (set_color red) (set_color normal); end
            end
        end
    end

    #** porcelain
    function _porcelain -S
        if test -n "$porcelain"
            set found true
            if ! $long
                printf " [%2s] $this \n" \
                (git status --porcelain 2>/dev/null | wc -l)
            else
                if test $counter -gt 0; printf "\n"; end
                printf "\n%s$this%s\n" (set_color -ou white) (set_color normal)
                set porcelain (string replace -a "D  " " D " "$porcelain")
                set porcelain (string replace -a "  "  "\n " "$porcelain")
                set porcelain (string replace -a " ?"  "\n " "$porcelain")
                printf "$porcelain\n"
            end
        else
            if $long; printf . ; end
            set clean (math $clean + 1)
        end
    end

    #** check dir in porcelain
    function _check_dir -S
        if ! test -d "$argv"
            printf "%s$argv%s %sis not a valid path\n" \
            (set_color -o red) \
            (set_color normal) \
            (set_color red)
            set_color normal
            set skipped (math $skipped + 1)
            return 1
        end
    end

    #* porcelain main
    function porcelain -S
        set -l current "$argv"
        if _check_dir "$current"; builtin cd "$current"
        else; return
        end
        set -l this (string replace $HOME "~" $current)
        set -l porcelain (git status --porcelain 2>/dev/null)
        _check_porcelain_status
        _porcelain
        set counter (math $counter + 1)
        builtin cd ..
    end

    function _check_relative_path -S
        if string match -qrv "~|$HOME" "$dir"
            set dir "$HOME/$dir"
        end
        _check_dir $dir
    end

    #* check groups
    function check_groups -S
        for dir in (string split " " $git_dirs)
            if _check_relative_path
                builtin cd $dir
                for project in (ls)
                    if test (string match -r "$excluded" "$project")
                        set skipped (math $skipped + 1)
                        continue
                    end
                    porcelain $project
                end
                builtin cd ..
            end
        end
    end

    function check_projects -S
        for dir in (string split " " $git_check_projects)
            if string match -qvr "~|$HOME" $dir
                set dir "$HOME/$dir"
            end
            if test (string match -r "$excluded" "$dir")
                set skipped (math $skipped + 1)
                continue
            end
            porcelain $dir
        end
    end

    #* walk through defined dirs
    if set -q _flag_project
        set -l project $_flag_project
        if string match -qrv "~|$HOME" $project
            set project "$HOME/$project"
        end
        porcelain "$project"
    else
        if set -q git_dirs; check_groups; end
        if set -q _flag_groupdirs; return; end
        if set -q git_check_projects; check_projects; end
    end

    #* print closing message
    if $long; printf "\n"; end
    if test \( $counter -eq $clean \) -a \( $counter -ne 0 \); set clean all; end
    printf "Checked %s%s%s project(s), %s%s%s clean" \
    (set_color -o brblue) $counter (set_color normal) \
    (set_color -o yellow) $clean (set_color normal)
    if test $skipped -gt 0
        printf ", %s%s%s skipped" \
        (set_color -o red) \
        $skipped \
        (set_color normal)
    end

    # return to where started
    builtin cd $CWD

end
