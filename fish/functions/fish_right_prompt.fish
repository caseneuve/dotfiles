# Last update: 20/01/2019

function fish_right_prompt -d "My right prompt: show last command duration time"
    # >> set colors for different periods 
    set -l time $CMD_DURATION
    if test $time -lt 100
        echo -n (set_color green)$time
    else if test $time -lt 250
        echo -n (set_color brgreen)$time
    else if test $time -lt 500
        echo -n (set_color bryellow)$time
    else if test $time -lt 1000
        echo -n (set_color yellow)$time
    else if test $time -lt 1500
        echo -n (set_color brred)$time
    else
        echo -n (set_color red)$time
    end

    # >> git status
    set -l GB (git branch 2>/dev/null | grep '^*' | colrm 1 2)
    if ! test -z $GB
        set -l GIT (git status 2>/dev/null)
        switch "$GIT"
            case '*use "git push"*'
                set -l GS "✔"
                printf "%s | %s%s %s%s " (set_color brblack) (set_color blue) $GB  (set_color yellow) $GS
        case '*nothing to commit*'
            set -l GS "✔"
            printf "%s | %s%s %s%s " (set_color brblack) (set_color blue) $GB  (set_color green) $GS
            case '*not staged*' \| '*Untracked*' \| '*modified*' \| '*to be committed*' \| '*deleted*'
                set -l GS "✗"
                printf "%s | %s%s %s%s " (set_color brblack) (set_color blue) $GB (set_color red) $GS
        end
    end
    set_color normal
end

