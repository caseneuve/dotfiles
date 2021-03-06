    #    #           #       #
   # #               #       #
   #    ##     ###   ###     #
  ###    #    ##     #  #    #
   #     #      ##   #  #
   #    ###   ###    #  #    #

# Last update: 2019-11-17, 15:23:40 @x200

#* VARIABLES
#** env vars
set -e  BROWSER
set -e  EDITOR
set -e  VISUAL
set -gx BROWSER /usr/bin/qutebrowser
set -gx EDITOR emacsclient -nw -s term
set -gx VISUAL $EDITOR
set -gx VIRTUAL_ENV_DISABLE_PROMPT no # https://github.com/fish-shell/fish-shell/pull/1795
set -gx TERM xterm-256color
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin $HOME/.local/bin $HOME/.scripts
set -gx LS_COLORS "di=1;34:*.pdf=00;91:ln=00;36:*.m3u=01;35:*.mp3=00;35:*.wav=00;35:*.7z=01;31:*.zip=01;31:*.rar=01;31:"
# prompt colors
set -gx fish_prompt_cwd_color    brwhite
set -gx fish_prompt_branch_color brblue
set -gx fish_prompt_venv_color   brred
set -gx fish_prompt_success      brgreen
set -gx fish_prompt_warning      brred
set -gx fish_prompt_commentary   white

#** fish vars
#set -e fish_greeting
set -gx fish_greeting
set -gx fish_color_cancel brcyan

#** color theme
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

#** colors for pager
set -gx LESS -R
set -gx LESS_TERMCAP_so \e'[01;37;31m' # begin reverse video
set -gx LESS_TERMCAP_se \e'[0m'        # reset reverse video
set -gx LESS_TERMCAP_us \e'[1;33m'     # begin underline
set -gx LESS_TERMCAP_ue \e'[0m'        # reset underline
set -gx LESS_TERMCAP_mb \e'[1;36m'     # begin bold
set -gx LESS_TERMCAP_md \e'[1;34m'     # begin blink
set -gx LESS_TERMCAP_me \e'[0m'        # reset bold/blink

#* SOURCE:
#** source funcs
# if test -d ~/.config/fish/functions
#     source ~/.config/fish/functions/*
# end

#** source fzf
if test -d ~/.fzf
    source ~/.fzf/shell/key-bindings.fish
    fzf_key_bindings
end


#* ABBREVS (~ aliases)
#if not set -q abbrs_initialized
if status --is-interactive
  #set -U abbrs_initialized
  set -g fish_user_abbreviations
  #echo -n Setting abbreviations...

#** source fast dirs
  if test -f $HOME/.dotfiles/fish/fast-dirs.fish
      source $HOME/.dotfiles/fish/fast-dirs.fish
  end

#** abbrev list
  # Django abbrevs:
  # abbr --add e $EDITOR
  abbr --add battery "upower -i (upower -e | awk '/batter/') | awk '/percentage/ {print \$2}'"
  abbr --add cd. cd ..
  abbr --add cd.. cd ../..
  abbr --add cd... cd ../../..
  abbr --add compton 'compton --config ~/.config/compton/compton.conf'
  abbr --add dps 'dropbox-cli status'
  abbr --add e $EDITOR
  abbr --add elg exa --group-directories-first
  abbr --add els exa
  abbr --add en emacsclient -n -a emacs
  abbr --add fdf fd -d 1 -t f
  abbr --add gita git add
  abbr --add gitc 'git commit -m'
  abbr --add gitca 'git commit -am'
  abbr --add gitcs 'git commit --author=schole -m'
  abbr --add gitl git pull
  abbr --add gitp git push
  abbr --add gits git status
  abbr --add gitx git-check
  abbr --add hs hugo server -vw
  abbr --add ipy ipython
  abbr --add klr ' clear'
  abbr --add l1 ls -1
  abbr --add lg ls --group-directories-first --color="always"
  abbr --add lg1 ls --group-directories-first -1
  abbr --add mdk 'mkdir -p'
  abbr --add mejk 'make && sudo make install'
  abbr --add mk mkdir -p
  abbr --add mkd 'mkdir -p'
  abbr --add mmg ./manage.py migrate
  abbr --add mms ./manage.py makemigrations
  abbr --add mrs ./manage.py runserver
  abbr --add ms ./manage.py shell_plus
  abbr --add mt ./manage.py test -v 2
  abbr --add mt1 ./manage.py test
  abbr --add q ' exit'
  abbr --add sc set_color
  abbr --add sp sudo pacman -S
  abbr --add sqlb sqlitebrowser
  abbr --add sr sudo pacman -R
  abbr --add x xclip -selection c
end

#* FUNCTIONS
#** reload config
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

#** yayup
function ya -d 'Update packages'
    yay
    checkupdates > /tmp/sysupdt
    echo hook:module/sysupdt1 >> /tmp/polybar-ipc-primary
end

#** psaux / psauk
function psaux -d 'Look for process id with ps'
    ps aux | grep $argv | grep -v grep
end

function psauk -d 'Kill all processes for the app name'
    psaux $argv | awk '{print $2}' | xargs kill -9
end

#** make symlink from pwd
function lns -d 'Make a symbolic link from current working dir'
    ln -s $PWD/$argv[1] $argv[2]
end

#** copy (path) to clipboard
function xc -d 'Copy arg to clipboard'
    command $argv | xclip -sel clip
end

function xp -d 'Copy full path to clipboard'
    command pwd | xclip -sel clip
end

#** update functions
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
