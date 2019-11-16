
  #    #           #                                          #
 # #               #                                          #
 #    ##     ###   ###         ###   ###    ##   # #   ###   ###
###    #    ##     #  #        #  #  #  #  #  #  ####  #  #   #
 #     #      ##   #  #        #  #  #     #  #  #  #  #  #   #
 #    ###   ###    #  #        ###   #      ##   #  #  ###     ##
                               #                       #

# Last update: 2019-11-16, 21:42:19 @lenovo


#* COLORS
set fish_prompt_cwd_color    yellow
set fish_prompt_branch_color brblue
set fish_prompt_venv_color   brred


#* HELPERS
#** line beggining
function line_beg -d "Success sensitive line beginning"
    if test $argv[2] = 0; printf '%s%s' (set_color -o brwhite) $argv[1]
    else;                 printf '%s%s' (set_color -o red)     $argv[1]
    end
    set_color normal
end


#** venv info
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


#** print CWD dwim
function pwd_dwim
    set -l PPWD (prompt_pwd)
    printf "%s%s%s%s" \
    (set_color -o white) \
    (set_color -o $fish_prompt_cwd_color) \
    (string replace -r "~/" "" -- $PPWD) \
    (set_color normal)
end


#** git branch and status
function git_status
    set -g GB (git branch 2>/dev/null | grep '^*' | colrm 1 2)
    set -g porcelain ""

    function git_format
        printf " %sin branch %s%s%s%s%s%s%s" \
        (set_color -o white) \
        (set_color normal) \
        (set_color -o $fish_prompt_branch_color) \
        $GB \
        (set_color normal) \
        (set_color -o red) \
        $argv[1..-1] \
        (set_color normal)
    end

    function update_changes
        set -l lookup (git status --porcelain 2>/dev/null | grep -o -c "$argv[1]")
        if test $lookup -gt 0; set -a porcelain (printf "%s%s" $argv[2] $lookup); end
    end

    if test -n "$GB"
        if test (git status 2>/dev/null | grep "use \"git push\""); set -a porcelain "P!"
        end
        update_changes " M "  "m"
        update_changes "^M "  "c"
        update_changes "^A "  "a"
        update_changes " D "  "d"
        update_changes "[??]" "u"

        git_format     "$porcelain"
    end
end


#* FISH PROMPT
function fish_prompt -d "My fish prompt"
    set -g STAT $status
    set -l TOP    "> "  # ╴ ╼ ☉ ╭╴╰╴
    set -l BOTTOM "> "

    line_beg $TOP $STAT
    pwd_dwim
    git_status
    venv_info
    printf "\n"
    line_beg $BOTTOM $STAT

    set -e porcelain
end

