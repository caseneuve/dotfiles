function colors -d 'print 256 colors'
    tput bold
    for number in (seq 256)
        tput setaf $number
        echo -n "color $number "
    end
end
