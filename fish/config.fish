
 ##  #      #    #  
 #       ## ###  #  
###  #   #  # #  #  
 #   ## ##  # #     
##               #  

# Last update: 20.01.19, 11:58:16 @lenovo

## >> VARIABLES
set -e BROWSER
set -e EDITOR
set -gx BROWSER /usr/bin/qutebrowser
set -gx EDITOR emacsclient -c -nw

## >> SOURCE:
# >>> source funcs
if test -d ~/.config/fish/functions
    source ~/.config/fish/functions/*
end

# >>> source fzf
if test -d ~/.fzf
    source ~/.fzf/shell/key-bindings.fish
    fzf_key_bindings
end


## >> ABBREVS
#if not set -q abbrs_initialized
if status --is-interactive
  #set -U abbrs_initialized
  set -g fish_user_abbreviations
  #echo -n Setting abbreviations...

  # >>> source fast dirs
  if test -f fast-dirs.fish
      source fast-dirs.fish
  end

  abbr --add klr clear
  abbr --add q exit
  abbr --add e $EDITOR
  abbr --add cd. cd ..
  abbr --add x xclip -selection c
  abbr --add sc set_color
  abbr --add gits git status
  abbr --add mk mkdir -p
  abbr --add lg ls --group-directories-first --color="always"

end

# >> functions
# >>> reload config 
function sfc -d 'Reload fish config'
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
function yup -d 'Update packages'
    yay -Syu && pkill -RTMIN+12 i3blocks
end

# psaux / psauk
function psaux -d 'Look for process id with ps'
    ps aux | grep $argv | grep -v grep
end

  
function psauk -d 'Kill all processes for the app name'
    psaux $argv | awk '{print $2}' | xargs kill -9
end

function lns -d 'Make a symbolic link from current working dir'
    ln -s $PWD/$argv[1] $argv[2]
end
                    
