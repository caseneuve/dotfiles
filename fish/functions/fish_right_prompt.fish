# Last update: 2019-11-17, 15:11:50 @x200

function fish_right_prompt -d "Custom right prompt: show last command duration time"
    function convert_ms -d "Convert milisecond to seconds/minutes"
        if      test $argv -lt 1000;     printf "%03d" $argv
        else if test $argv -lt 60000;    printf "%2ss" (math -s0 $argv/1000.0)
        else if test $argv -le 3600000;  printf "%2sm" (math -s0 $argv/60000)
        else if test $argv -le 86400000; printf "%3sh" (math -s1 $argv/3600000)
        else;                            printf "%3sd" (math -s1 $argv/86400000)
        end
    end

    function colorize
        printf "%s%s" (set_color $argv[1]) (convert_ms $argv[2])
    end
    
    set -l time $CMD_DURATION

    if      test $time -lt 100;   colorize green    $time
    else if test $time -lt 250;   colorize brgreen  $time
    else if test $time -lt 500;   colorize bryellow $time
    else if test $time -lt 1000;  colorize yellow   $time
    else if test $time -lt 1500;  colorize brred    $time
    else if test $time -lt 60000; colorize red      $time
    else;                         colorize brblack  $time
    end

    if test $STAT = 0; printf " %s<%s" (set_color -o $fish_prompt_success) (set_color normal)
    else;              printf " %s<%s" (set_color -o $fish_prompt_warning)  (set_color normal)
    end
        
end

