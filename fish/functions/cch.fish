function cch -d "copy command from history selected with fzf"
    set cmd (history | fzf)
    echo $cmd | xclip -selection clipboard
end
