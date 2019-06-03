
  #    #           #                                          #    
 # #               #                                          #    
 #    ##     ###   ###         ###   ###    ##   # #   ###   ###   
###    #    ##     #  #        #  #  #  #  #  #  ####  #  #   #    
 #     #      ##   #  #        #  #  #     #  #  #  #  #  #   #    
 #    ###   ###    #  #        ###   #      ##   #  #  ###     ##  
                               #                       #           

# Last update: 2019-06-03, 17:57:07 @toshiba

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
        printf "%s%s ║ %s" (set_color magenta) (basename "$VIRTUAL_ENV") \
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
    if ! test -z $GB
        set -l GIT (git status 2>/dev/null)
        switch "$GIT"
            case '*use "git push"*'
                set -l GS "✔"
                printf "  %s  %s %s%s " (set_color blue) $GB  (set_color yellow) $GS
            case '*nothing to commit*'
                set -l GS "✔"
                printf "  %s  %s %s%s " (set_color blue) $GB  (set_color green) $GS
            case '*not staged*' \| \
                '*Untracked*' \| \
                '*modified*' \| \
                '*to be committed*' \
                \| '*deleted*'
                set -l GS "✗"
                printf "  %s  %s %s%s " (set_color blue) $GB (set_color red) $GS
        end
    end
end

#**  cmd duration
# set colors for different periods
function cmd_duration
    function convert_ms -d "Convert milisecond to seconds/minutes"
        set -l ms $argv
        if test $ms -lt 1000
            echo $ms
        else if test $ms -lt 60000
            echo (math -s2 "$ms/1000") s
        else if test $ms -le 3600000
            echo (math -s2 "$ms/60000") m
        else if test $ms -le 86400000
            echo (math -s2 "$ms/3600000") h
        else
            echo (math -s2 "$ms/86400000") d
        end
    end

    set -l time $CMD_DURATION
    if test $time -lt 100
        printf "%s%s " (set_color green)(convert_ms $time)
    else if test $time -lt 250
        printf "%s%s " (set_color brgreen)(convert_ms $time)
    else if test $time -lt 500
        printf "%s%s " (set_color bryellow)(convert_ms $time)
    else if test $time -lt 1000
        printf "%s%s " (set_color yellow)(convert_ms $time)
    else if test $time -lt 1500
        printf "%s%s " (set_color brred)(convert_ms $time)
    else
        printf "%s%s " (set_color red)(convert_ms $time)
    end
end

#* 2 MAIN
function fish_prompt -d "My fish prompt"
    set -l STAT $status
    set -l TOP "╭╴"
    set -l BOTTOM "╰╴"
    line_beg $TOP $STAT
    venv_info
    pwd_dwim
    git_status
    printf "\n"
    line_beg $BOTTOM $STAT
    cmd_duration
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
