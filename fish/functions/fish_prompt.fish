
  #    #           #                                          #
 # #               #                                          #
 #    ##     ###   ###         ###   ###    ##   # #   ###   ###
###    #    ##     #  #        #  #  #  #  #  #  ####  #  #   #
 #     #      ##   #  #        #  #  #     #  #  #  #  #  #   #
 #    ###   ###    #  #        ###   #      ##   #  #  ###     ##
                               #                       #

# Last update: 2019-11-16, 18:54:07 @lenovo

#* COLORS
set fish_prompt_cwd_color    yellow
set fish_prompt_branch_color brblue
set fish_prompt_venv_color   brred

#* HELPERS
#** line beg
function line_beg -d "Success sensitive line beginning"
    if test $argv[2] = 0; printf '%s%s' (set_color brwhite) $argv[1]
    else;                 printf '%s%s' (set_color -o red)     $argv[1]
    end
    set_color normal
end

function venv_info -d "Show virtual env if active"
    if set -q VIRTUAL_ENV
        printf " %sworkon%s %s%s%s" \
        (set_color -o white) \
        (set_color normal) \
        (set_color -o $fish_prompt_venv_color) \
        (basename "$VIRTUAL_ENV") \
        (set_color normal)
    end
end

#** print CWD with status indicator
function pwd_dwim
    set -l PPWD (prompt_pwd)
    printf "%s%s%s%s" \
    (set_color -o white) \
    (set_color -o $fish_prompt_cwd_color) \
    (string replace -r "~/" "" -- $PPWD) \
    (set_color normal)
end

#** git status
function git_status
    set -l GB (git branch 2>/dev/null | grep '^*' | colrm 1 2)

    function git_format
        printf " %sin branch%s %s%s%s" \
        (set_color -o white) \
        (set_color normal) \
        (set_color -o $fish_prompt_branch_color) \
        $argv[1] \
        (set_color normal)
    end


    if test -n "$GB"
        set -l CLEAN "✔"
        set -l DIRTY "✗"
        set -l GIT (git status 2>/dev/null)

        switch "$GIT"
            case '*No commits yet*'; git_format $GB -o magenta " no commits yet"
            case '*use "git push"*'; git_format $GB -o yellow $CLEAN
            case '*nothing to commit*'; git_format $GB -o green $CLEAN
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

#* MAIN
function fish_prompt -d "My fish prompt"
    # ╴ ╼ ☉ ╭╴╰╴
    set -g STAT $status
    set -l TOP "> "
    set -l BOTTOM "> "

    line_beg $TOP $STAT
    pwd_dwim
    git_status
    venv_info
    printf "\n"
    line_beg $BOTTOM $STAT
end

