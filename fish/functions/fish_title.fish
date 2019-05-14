function fish_title -d "Title for the terminal window: display last command"
    # if test -n "$argv[1]"
    #     set cmd "$argv[1]"
    # else
    #     if test -d "$history[1]"
    #         set cmd "cd"
    #     else
    #         set cmd "$history[1]"
    #     end
    # end
    printf "%s %s %s %s" (date '+%H:%M:%S') (pwd) \$ "$argv[1]"
end
