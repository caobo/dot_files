#!/usr/bin/env zsh
# zshrc file
# Author: Bo Cao
# Date: May 28, 2023
# --------------------

# Export global environment variables
# --------------------
export PATH="$HOME/.local/bin:$PATH"  # Add local binaries to PATH
export XDG_CONFIG_HOME="$HOME/.config"  # Set XDG_CONFIG_HOME to ~/.config
export MPLCONFIGDIR="$HOME/.config/matplotlib"  # Set Matplotlib configuration directory
export EDITOR=nvim  # Set default editor to nvim
export LANG=en_US.UTF-8  # Set default language to US English
export TERM=xterm-256color  # Set terminal type to xterm-256color
if [ $(uname) = "Darwin" ]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/python/libexec/bin:$PATH"  # Add Homebrew binaries to PATH
    export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"  # Set LDFLAGS for OpenBLAS
    export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"  # Set CPPFLAGS for OpenBLAS
    export PKG_CONFIG_PATH="/opt/homebrew/opt/openblas/lib/pkgconfig"  # Set PKG_CONFIG_PATH for OpenBLAS
fi
# if [ $(uname) = "Linux" ]; then
    # export XDG_SESSION_TYPE=wayland
    # export MOZ_ENABLE_WAYLAND=1
    # export QT_QPA_PLATFORM="wayland;xcb"
    # export XDG_CURRENT_DESKTOP=Hyprland
    # export XDG_CURRENT_SESSION=Hyprland
    # export LIBSEAT_BACKEND=logind
    # export GDK_DPI_SCALE=1
    # export QT_SCALE_FACTOR=1
    # export WLR_DRM_NO_MODIFIERS=1
# fi

# Settings for oh-my-zsh
# --------------------
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
# Set the theme to jovial/jovial
ZSH_THEME="jovial/jovial"

# Custom plugins
plugins=(
    z
    colored-man-pages
    fast-syntax-highlighting
    zsh-autosuggestions
)

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-${ZSH_VERSION}
source $ZSH/oh-my-zsh.sh

# User configuration
# --------------------
LESS=-RFX  # Set LESS options for displaying man pages

# Enable fzf fuzzy completion
[ -f $HOME/.config/zsh/fzf.zsh ] && source $HOME/.config/zsh/fzf.zsh

# Custom functions
# --------------------

# Create and change to a newly created directory
mcd() {
   [[ -n $@ ]] && mkdir -p "$@" && cd "$@" || echo "Please name a directory to create."
}

# Functions for quickly adding and jumping to "goto" directories
GT_LIST="$HOME/.config/zsh/gt_list"
adgt() {
    # Create a goto directory
    [[ -d $HOME/.config/zsh ]] || mkdir "$HOME/.config/zsh"
    [[ -z $@ ]] && echo "$(pwd)" >> "$GT_LIST" || echo "$@" >> "$GT_LIST"
}

rmgt() {
    # Remove a goto directory
    local LINE=$(< "$GT_LIST" |
        fzf --height=~100% --cycle --info=inline --border=rounded)
    [[ -z $LINE ]] && echo "Please select a goto directory to delete." || sed -i '' "\|"$LINE"$|d" "$GT_LIST"
}

gt() {
    # Jump to a goto directory
    local GT_DIR=$(bat "$GT_LIST" |
        fzf --height=~100% --cycle --preview 'ls {}' --info=inline --border=rounded)
    [[ -z $GT_DIR ]] && echo "Please select a goto directory to navigate to." || cd "$GT_DIR"
}

# More custom functions
open_applications() {
    # Open selected application from /Applications/
    local SELECTED_APP=$(fd '.*\.app$' /Applications -d 2|
        fzf --height=~100% --cycle --info=inline --border=rounded --preview 'bat {}')
    [[ -z $SELECTED_APP ]] && echo "Please select an app." || open "$SELECTED_APP"
}

current_folder_edit() {
    # Edit selected file in the current folder
    local FILE=$(fd '.*' $(pwd) -t f -x file --mime-type |
        awk -F ':' '/.*\:.*text|empty/ { print $1}' |
        fzf --height=~100% --cycle --preview 'bat --color=always {}' --info=inline --border=rounded)
    [[ -z $FILE ]] && echo 'Please select a file.' || nvim "$FILE"
}

dot_folder_edit() {
    # Edit selected file in the dot_files folder
    local FILE=$(fd '.*' "$HOME/Documents/Software/dot_files" -t f -x file --mime-type |
        awk -F ':' '/.*\:.*text|empty/ { print $1}' |
        fzf --height=~100% --cycle --preview 'bat --color=always {}' --info=inline --border=rounded)
    [[ -z $FILE ]] && echo "Please select a file." || nvim "$FILE"
}

open_xplr() {
    # Use xplr to open a file or directory in the default app
    local TARGET=$(xplr $1)
    [[ -z $TARGET ]] || ( $(file -b $TARGET | rg -q 'text|empty') && nvim $TARGET || open "$TARGET")
}

open_with_xplr() {
    # Open selected item with xplr
    local FOLDER=$(fd '.*' $(pwd) -t d -d 3 |
        fzf --height=~100% --cycle --preview 'ls {}' --info=inline --border=rounded)
    [[ -z $FOLDER ]] && echo "Please select a folder." || open_xplr "$FOLDER"
}

open_in_finder() {
    # Open selected folder in Finder
    local FOLDER=$(fd '.*' $(pwd) -t d -d 3 |
        fzf --height=~100% --cycle --preview 'ls {}' --info=inline --border=rounded)
    [[ -z $FOLDER ]] && echo "Please select a folder." || open "$FOLDER"
}

search_command_history() {
    # Search the command history using fzf
    local FILE=$HOME/.zsh_history
    local CMD=$(awk -F ';' '!seen[$2]++ {print $2}' "$FILE" | fzf --height=30% --cycle --info=inline --border=rounded --preview 'echo {}')
    eval "$CMD"
}

spell() {
    # Spell check function
    if [ $(uname) = "Darwin" ]; then
        [[ -n $1 ]] && local WORD=$1 || local WORD=$(pbpaste|less)
    fi
    if [ $(uname) = "Linux" ]; then
        [[ -n $1 ]] && local WORD=$1 || local WORD=$(wl-paste|less)
    fi
    local CSPELL=$(echo "$WORD" | aspell pipe | awk -F ':' '{print $2}' | tr ',' '\n' | fzf --height=~50% --layout reverse-list)
    if [ $(uname) = "Darwin" ]; then
        [[ -n $CSPELL ]] && echo $CSPELL | pbcopy
    fi
    if [ $(uname) = "Linux" ]; then
        [[ -n $CSPELL ]] && echo "$CSPELL" | wl-copy
    fi
}

# Aliases
alias latexmk='latexmk -quiet 1> /dev/null'
alias {vi,vim}='nvim'
alias cat='bat'
alias xr='open_xplr'

# Key bindings
bindkey -s '^o' 'open_applications\n'
bindkey -s '^e' 'current_folder_edit\n'
bindkey -s '^k' 'dot_folder_edit\n'
bindkey -s '^g' 'gt\n'
bindkey -s '^x' 'open_with_xplr\n'
bindkey -s '^r' 'search_command_history\n'

# More color and theme related settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="underline"

source "$HOME/.config/zsh/jovial_setting.zsh"

export BAT_THEME="ansi"

export FZF_DEFAULT_OPTS="
    --color=fg:#908caa,bg:#232136,hl:#ea9a97
    --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
    --color=border:#44415a,header:#3e8fb0,gutter:#232136
    --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
"

# Show a greeting message
greet_message="
  .---------------------------.
  | May the phase be with you |
  '---------------------------'
      ^      (\_(\ \r
      '----- ( -.-) \r
             o_(\")(\")
"
echo -e "$greet_message"

KITTY_ENABLE_WAYLAND=1
