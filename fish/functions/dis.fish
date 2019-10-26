function dis -d 'disown process(es) of current shell'
    while test (jobs -c | grep "$argv[1]")
        jobs | awk -v job="$argv[1]" '{if ($5 = job) {print $2}}' | disown
    end
end

complete -c dis -x -a "(jobs -c | sed -n '/Command/!p' | uniq)"
