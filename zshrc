#!/usr/bin/env zsh
# zshrc file
# Author: Bo Cao
# Date: May 28, 2023
# --------------------

# zap plugin manager settings
# --------------------
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "zthxxx/jovial"
source "$HOME/.local/share/zap/plugins/jovial/jovial.zsh-theme"

# Load and initialise completion system
autoload -Uz compinit
compinit

# User configuration
# --------------------
LESS=-RFX  # Set LESS options for displaying man pages

# Enable fzf fuzzy completion
[ -f "$HOME/.config/zsh/fzf.zsh" ] && source "$HOME/.config/zsh/fzf.zsh"

# Custom functions
# --------------------

# Create and change to a newly created directory
mcd() {
   [ -n "$@" ] && mkdir -p "$@" && cd "$@" || echo "Please name a directory to create."
}

gt() {
    GT_LIST="$HOME/.config/zsh/gt_list"
    GT_DIR="$(cat "$GT_LIST" | fzf --height=~100% --cycle --preview 'ls {}' --info=inline --border=rounded)"
    [ -n "$GT_DIR" ] && cd "$GT_DIR" || echo "Please select a goto directory to navigate to."
}

# Functions for quickly adding and jumping to "goto" directories

# Aliases
alias latexmk='latexmk -quiet 1> /dev/null'
alias {vi,vim}='nvim'
alias cat='bat'
alias xr='open_xplr'
alias wttr='curl https://wttr.in'
alias sysinfo='curl -sL https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash'
alias ll='ls -lh'
alias la='ls -alh'
if [ "$(uname)" = "Darwin" ]; then
    alias stat='stat -x'
fi

# Key bindings
if [ "$(uname)" = "Darwin" ]; then
    bindkey -s '^o' 'open_applications\n'
fi
bindkey -s '^k' 'dot_folder_edit\n'
bindkey -s '^e' 'current_folder_edit\n'
bindkey -s '^x' 'open_with_xplr\n'
bindkey -s '^g' 'gt\n'
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
greet_message="\
  .----------------------------.
  | May the phase be with you. |
  '----------------------------'
      ^      (\_(\ \r
      '----- ( -.-) \r
             o_(\")(\") \
"
echo "$greet_message"

if [ "$(uname)" = "Linux" ]; then
    KITTY_ENABLE_WAYLAND=1
fi
