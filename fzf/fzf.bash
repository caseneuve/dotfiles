# Path:        ~/.dotfiles/fzf/fzf.bash
# Created:     29.03.18, 11:02    @manjaroi3
# Last update: 29.03.18, 14:46:28 @manjaroi3

# Doc: Config & functions for FUZZY FINDER

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
# Alt-c
export FZF_ALT_C_COMMAND='fd -H --type d . ~'

# Default options
# --------------
export FZF_DEFAULT_OPTS='--height 50% --reverse --border --inline-info'
export FZF_DEFAULT_COMMAND='fd --type f . ~'
export FZF_COMPLETION_TRIGGER='~~'

# Aliasy
# ------
# przejrzyj zawartość plików tekstowych w danym katalogu
alias ffp="fd --type f -E '*.pdf' -E '*.mp?' -E '*.pyc' -E '*.RData' -E '*.png' . ./ | fzf --reverse --height 100% --border --inline-info --preview 'head -100 {}'"

# FUNCTIONS
# ---------

# find pdf and open with preferred app (mupdf)
fp () {
    xdg-open "$(fd -e pdf . ~ | fzf --height 50% --reverse --border --inline-info)" &>/dev/null
}

# find music file and play it with mocp
fm () {
    mocp -l "$(fd -e mp3 . ~ | fzf --height 50% --reverse --border --inline-info)" &>/dev/null
}

# find file and open it in emacsclient (don't look for multimedia or non textual files)
fe () {
    emacsclient -nw "$(fd --type f . ~ -E '*.mp?' -E '*.jpg' -E '*.png' -E '*.pdf' -E '*.aux' -E '*.doc*' -E '*.out' -E '*.mkv' | fzf --height 50% --reverse --border --inline-info)" 
} 

# find object and copy it to clipboard 
fx () {
    fzf | xclip -selection c
}

