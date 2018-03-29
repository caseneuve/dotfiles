# Path:        ~/.dotfiles/fzf/fzf.bash
# Created:     29.03.18, 11:02    @manjaroi3
# Last update: 29.03.18, 13:59:34 @manjaroi3

# Doc: functions for fuzzy finder

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/piotr/.fzf/bin* ]]; then
  export PATH="$PATH:/home/piotr/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/piotr/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/piotr/.fzf/shell/key-bindings.bash"

# default options
export FZF_DEFAULT_OPTS='--height 50% --reverse --border --inline-info'
export FZF_DEFAULT_COMMAND='fd --type f . ~'
export FZF_COMPLETION_TRIGGER='~~'

# Alt-c
export FZF_ALT_C_COMMAND='fd --type d . ~'

# FUNCTIONS
fp () {
    xdg-open "$(fd -e pdf . ~ | fzf --height 50% --reverse --border --inline-info)" &>/dev/null
}

fm () {
    mocp -l "$(fd -e mp3 . ~ | fzf --height 50% --reverse --border --inline-info)" &>/dev/null
}

fe () {
    emacsclient -nw "$(fd --type f . ~ -E '*.mp?' -E '*.jpg' -E '*.png' -E '*.pdf' -E '*.aux' -E '*.doc*' -E '*.out' -E '*.mkv' | fzf --height 50% --reverse --border --inline-info)" 
} 

