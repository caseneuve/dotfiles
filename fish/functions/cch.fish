function cch -d "copy command from history selected with fzf"
    set cmd (history | fzf)
    echo $cmd | xclip -selection clipboard
    notify-send "Fish" "<i>$cmd</i><br>copied to clipboard"
end
