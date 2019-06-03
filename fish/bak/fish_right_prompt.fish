# Last update: 2019-06-03, 17:59:31 @toshiba
# Doc:         This functionality has been moved to normal prompt

function fish_right_prompt -d "My right prompt: show last command duration time"
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

    # >> set colors for different periods 
    set -l time $CMD_DURATION
    if test $time -lt 100
        echo -n (set_color green)(convert_ms $time)
    else if test $time -lt 250
        echo -n (set_color brgreen)(convert_ms $time)
    else if test $time -lt 500
        echo -n (set_color bryellow)(convert_ms $time)
    else if test $time -lt 1000
        echo -n (set_color yellow)(convert_ms $time)
    else if test $time -lt 1500
        echo -n (set_color brred)(convert_ms $time)
    else
        echo -n (set_color red)(convert_ms $time)
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

