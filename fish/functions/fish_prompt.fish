
  #    #           #                                          #
 # #               #                                          #
 #    ##     ###   ###         ###   ###    ##   # #   ###   ###
###    #    ##     #  #        #  #  #  #  #  #  ####  #  #   #
 #     #      ##   #  #        #  #  #     #  #  #  #  #  #   #
 #    ###   ###    #  #        ###   #      ##   #  #  ###     ##
                               #                       #

# Last update: 2019-11-17, 16:03:07 @x200


#* COLORS
if test ! (set -q fish_prompt_cwd_color);    set -gx fish_prompt_cwd_color    brwhite; end
if test ! (set -q fish_prompt_branch_color); set -gx fish_prompt_branch_color brblue;  end
if test ! (set -q fish_prompt_venv_color);   set -gx fish_prompt_venv_color   brred;   end
if test ! (set -q fish_prompt_success);      set -gx fish_prompt_success      brgreen; end
if test ! (set -q fish_prompt_warning);      set -gx fish_prompt_warning      brred;   end
if test ! (set -q fish_prompt_commentary);   set -gx fish_prompt_commentary   white;   end

#* HELPERS
#** line beggining
function line_beg -d "Success sensitive line beginning"
    if test $argv[2] = 0; printf '%s%s' (set_color -o $fish_prompt_success) $argv[1]
    else;                 printf '%s%s' (set_color -o $fish_prompt_warning) $argv[1]
    end
    set_color normal
end


#** venv info
function venv_info -d "Show virtual env if active"
    if set -q VIRTUAL_ENV
        printf " %sworkon%s %s%s" \
          (set_color -o $fish_prompt_commentary) \
          (set_color normal) \
          (set_color -o $fish_prompt_venv_color) \
          (basename "$VIRTUAL_ENV")

        set_color normal
    end
end


#** print CWD dwim
function pwd_dwim
    set -l PPWD (prompt_pwd)

    printf "%s%s%s" \
      (set_color -o $fish_prompt_cwd_color) \
      (string replace -r "~/" "" -- $PPWD)

    set_color normal
end


#** git branch and status
function git_status
    set -l GB (git branch 2>/dev/null | grep '^*' | colrm 1 2)
    set -l porcelain

    function git_format --no-scope-shadowing
        set -l loc ""
        set -l space

        if test ! (git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>/dev/null)
            set -p loc "local "
        end

        if test -n "$argv[1]"; set -a space " "; end

        printf " %sin %sbranch %s%s%s%s%s%s%s%s" \
          (set_color -o $fish_prompt_commentary) \
          $loc \
          (set_color -o $fish_prompt_branch_color) \
          $GB \
          $space \
          (set_color normal) \
          (set_color -b blue) \
          $argv[1..-1] \
          (set_color normal)
    end

    function update_changes --no-scope-shadowing
        set -l lookup (git status --porcelain 2>/dev/null | grep -o -c "$argv[1]")
        if test $lookup -gt 0; set -a porcelain (printf "%s%s" $argv[2] $lookup); end
    end

    if test -n "$GB"
        if test (git status 2>/dev/null | grep "use \"git push\""); set -a porcelain "push"
        end

        if test (git status --porcelain --branch 2>/dev/null | grep "ahead [0-9]*, behind")
            set -a porcelain "diverged"
        end

        update_changes " M "  "m"
        update_changes "^M "  "c"
        update_changes "^A "  "A"
        update_changes " D "  "d"
        update_changes "^D "  "D"
        update_changes "[??]" "u"

        git_format     "$porcelain"
    end
end


#* FISH PROMPT
function fish_prompt -d "Custom fish prompt: shows CWD, branch and venv info, last command duration and exit success."
    # note: this has to be globally set because right prompt uses is too
    set -g STAT $status
    # ╴ ╼ ☉ ╭╴╰╴
    set -l TOP    "> "
    set -l BOTTOM "> "

    line_beg $TOP $STAT
    pwd_dwim
    git_status
    venv_info
    printf "\n"
    line_beg $BOTTOM $STAT
end

