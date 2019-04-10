
 ##  #      #    #  
 #       ## ###  #  
###  #   #  # #  #  
 #   ## ##  # #     
##               #  

# Last update: 2019-04-10, 20:41:14 @lenovo

# TODOS:
# todo: 20/01/2019, move all global vars to universal vars:
# - https://fishshell.com/docs/current/tutorial.html#tut_universal
# - https://stackoverflow.com/questions/25632846/how-to-set-environment-variables-in-fish-shell#comment75000885_30187924

## >> VARIABLES
# >>> env vars
set -e BROWSER
set -e EDITOR
set -e VISUAL
set -gx BROWSER /usr/bin/qutebrowser
set -gx EDITOR emacsclient -nw -s term
set -gx VISUAL $EDITOR
set -gx VIRTUAL_ENV_DISABLE_PROMPT no # https://github.com/fish-shell/fish-shell/pull/1795
set -gx TERM xterm-256color
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# >>> fish vars
#set -e fish_greeting
set -gx fish_greeting
set -gx fish_color_cancel brcyan

# >>> color theme
set fish_color_comment        magenta
set fish_color_command        brblue --bold
set fish_color_cancel         brred
set fish_color_autosuggestion yellow
set fish_color_end            bryellow
set fish_color_error          red --bold
set fish_color_operator       bryellow
set fish_color_param          brmagenta --bold
set fish_color_quote          green
set fish_color_redirection    blue
set fish_color_search_match   --background=magenta
set fish_color_selection      -r
set fish_color_valid_path     green
set fish_color_escape         brcyan

## >> SOURCE:
# >>> source funcs
# if test -d ~/.config/fish/functions
#     source ~/.config/fish/functions/*
# end

# >>> source fzf
if test -d ~/.fzf
    source ~/.fzf/shell/key-bindings.fish
    fzf_key_bindings
end


## >> ABBREVS (~ aliases)
#if not set -q abbrs_initialized
if status --is-interactive
  #set -U abbrs_initialized
  set -g fish_user_abbreviations
  #echo -n Setting abbreviations...

  # >>> source fast dirs
  if test -f $HOME/.dotfiles/fish/fast-dirs.fish
      source $HOME/.dotfiles/fish/fast-dirs.fish
  end

  abbr --add klr ' clear'
  abbr --add q ' exit'
  # abbr --add e $EDITOR
  abbr --add e $EDITOR
  abbr --add en emacsclient -n -a emacs
  abbr --add cd. cd ..
  abbr --add cd.. cd ../..
  abbr --add cd... cd ../../..
  abbr --add x xclip -selection c
  abbr --add sc set_color
  abbr --add gits git status
  abbr --add gitl git pull
  abbr --add gitp git push
  abbr --add gita git add
  abbr --add gitc 'git commit -m'
  abbr --add gitca 'git commit -am'
  abbr --add mk mkdir -p
  abbr --add lg ls --group-directories-first --color="always"
  abbr --add mejk 'make && sudo make install'
  abbr --add sp sudo pacman -S
  abbr --add sr sudo pacman -R
  abbr --add dps 'dropbox-cli status'
  abbr --add ipy ipython
  abbr --add mdk 'mkdir -p'
  abbr --add mkd 'mkdir -p'
  abbr --add compton 'compton --config ~/.config/compton/compton.conf'
  abbr --add sqlb sqlitebrowser
  abbr --add hs hugo server -vw
  abbr --add fdf fd -d 1 -t f 

end

# >> FUNCTIONS
# >>> reload config 
function sfc -d 'Reload fish config'
    update_functions
    source ~/.config/fish/config.fish >/dev/null
  if test $status = 0
      set_color -i blue
      echo "* Fish config reloaded! *"
      set_color normal
  else
     echo Could not reload Fish config...
  end
end

function p1 -d 'Ping 1.1.1.1'
    ping 1.1.1.1
end

# >>> yayup
function ya -d 'Update packages'
    yay && pkill -RTMIN+12 i3blocks
end

# >>> psaux / psauk
function psaux -d 'Look for process id with ps'
    ps aux | grep $argv | grep -v grep
end

function psauk -d 'Kill all processes for the app name'
    psaux $argv | awk '{print $2}' | xargs kill -9
end

# >>> make symlink from pwd
function lns -d 'Make a symbolic link from current working dir'
    ln -s $PWD/$argv[1] $argv[2]
end

# >>> copy (path) to clipboard
function xc -d 'Copy arg to clipboard'
    command $argv | xclip -sel clip
end

function xp -d 'Copy full path to clipboard'
    command pwd | xclip -sel clip
end

# >>> update functions
function update_functions -d 'Update function files'
    set -l DOT ~/.dotfiles/fish/functions/
    set -l CFG ~/.config/fish/functions/
    set -l updt false

    if ! test -d $CFG
        mkdir -p $CFG
    end
    
    for file in (ls $DOT)
        if test -L $CFG$file
            continue
        else
            ln -s $DOT$file $CFG
            set_color -i blue
            echo "* Missing file '$file' symlinked... *"
            set updt true 
        end
    end
    if $updt
        source $CFG* && echo "* Functions updated! *"
        set_color normal
    end
end

update_functions
