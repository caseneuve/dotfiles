
  #    #           #                                          #    
 # #               #                                          #    
 #    ##     ###   ###         ###   ###    ##   # #   ###   ###   
###    #    ##     #  #        #  #  #  #  #  #  ####  #  #   #    
 #     #      ##   #  #        #  #  #     #  #  #  #  #  #   #    
 #    ###   ###    #  #        ###   #      ##   #  #  ###     ##  
                               #                       #           

# Last update: 2019-06-03, 20:01:32 @toshiba

#* 1 HELPERS
#**  line beg
function line_beg -d "Success sensitive line beginning"
    if test $argv[2] = 0
        printf '%s%s ' (set_color normal) $argv[1]
    else
        printf '%s%s ' (set_color -o red) $argv[1]
    end
end

#**  virtual env / venv
function venv_info -d "Show virtual env if active"
    if set -q VIRTUAL_ENV
        printf " %s(%s)%s" (set_color --bold magenta) (basename "$VIRTUAL_ENV") \
        (set_color normal)
    end
end

#**  print CWD with status indicator
function pwd_dwim
    set -l PPWD (prompt_pwd)
    printf "%s%s%s" \
    (set_color -o white) \
    (string replace -r "~/" "" -- $PPWD) \
    (set_color normal)
end

#**  git status
function git_status
    set -l GB (git branch 2>/dev/null | grep '^*' | colrm 1 2)

    function git_format
        printf " %s[%s]%s %s%s " (set_color -o blue) $argv[1] (set_color normal) (set_color $argv[2..3]) $argv[4..-1]
    end
    
    if test -n $GB
        set -l CLEAN ✔
        set -l DIRTY ✗
        set -l GIT (git status 2>/dev/null)
        switch "$GIT"
            # case '*Changes to be committed*'
            #     set -l tocommit (count (echo $GIT | grep "new file"))
            #     set -l GB master
            #     git_format $GB -r brblack " $tocommit to commit"
            # case '*Untracked files*'
            #     set -l untracked (count (echo $GIT | grep "\t"))
            #     git_format master -dr magenta " $untracked untracked"
            case '*No commits yet*'
                git_format master -o magenta " no commits yet"
            case '*use "git push"*'
                git_format $GB -o yellow $CLEAN
            case '*nothing to commit*'
                git_format $GB -o green $CLEAN
            case '*not staged*' \| \
                '*Untracked*' \| \
                '*modified*' \| \
                '*to be committed*' \
                \| '*deleted*'
                git_format $GB -o red $DIRTY
        end
    end
    set_color normal
end

#** cmd duration time
# set colors for different periods
function cmd_duration
    function convert_ms -d "Convert milisecond to seconds/minutes"
        if test $argv -lt 1000
            printf "%03d" $argv
        else if test $argv -lt 60000
            printf "%2ss" (math -s0 $argv/1000.0) 
        else if test $argv -le 3600000
            printf "%2sm" (math -s0 $argv/60000) 
        else if test $argv -le 86400000
            printf "%3sh" (math -s1 $argv/3600000) 
        else
            printf "%3sd" (math -s1 $argv/86400000)
        end
    end

    set -l time $CMD_DURATION
    if test $time -lt 100
        printf "%s%s " (set_color --bold green)(convert_ms $time)
    else if test $time -lt 250
        printf "%s%s " (set_color --bold brgreen)(convert_ms $time)
    else if test $time -lt 500
        printf "%s%s " (set_color --bold bryellow)(convert_ms $time)
    else if test $time -lt 1000
        printf "%s%s " (set_color --bold yellow)(convert_ms $time)
    else if test $time -lt 1500
        printf "%s%s " (set_color --bold brred)(convert_ms $time)
    else if test $time -lt 60000
        printf "%s%s " (set_color --bold red)(convert_ms $time)
    else
        printf "%s%s " (set_color -o --bold brblack)(convert_ms $time)
    end
end

#* 2 MAIN
function fish_prompt -d "My fish prompt"
    set -l STAT $status
    set -l TOP "╭╴"
    set -l BOTTOM "╰╴"
    line_beg $TOP $STAT
    cmd_duration
    pwd_dwim
    venv_info
    git_status
    printf "\n"
    line_beg $BOTTOM $STAT
end

#* 3 END
# func: add_icons
# function add_icons -d "Return appropriate symbol if $CWD is a special context"
#     set -l dir "$PWD"
#     set_color normal
# if test (string match -a "/home/piotr" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -r "/org" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -ir "/.conf" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -ir "/szk" "$dir")
#     echo (set_color  white)"  "(set_color normal)
# else if test (string match -ir "/wiki" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -ir "/\.virtualenvs" "$dir")
#     echo (set_color white)" "(set_color normal)
# else if test (string match -r "box/Dropbox" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -r "/dwl" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -r "git/lab" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -r "git/hub" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (git rev-parse --git-dir 2> /dev/null)
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -r "/pdf" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -r "/wid" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -r "/muz" "$dir")
#     echo (set_color white)"  "(set_color normal)
# else if test (string match -r "/obr" "$dir")
#     echo (set_color white)"  "(set_color normal)
# end
#end
