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
plug "zdharma-continuum/fast-syntax-highlighting"

# Start starship prompt
eval "$(starship init zsh)"

# Load and initialise completion system
autoload -Uz compinit
compinit
setopt APPEND_HISTORY
setopt SHARE_HISTORY
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# Autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# User configuration
# --------------------
LESS=-RFX  # Set LESS options for displaying man pages
export MANPAGER="/usr/bin/less -R --use-color -Ddg -Du+y"

# Enable fzf fuzzy completion
[ -f "$HOME/.config/zsh/fzf.zsh" ] && source "$HOME/.config/zsh/fzf.zsh"

# lf file manager icon configuration
export LF_ICONS=$(cat ~/.config/lf/ICONS)

# Custom functions
# --------------------

# Create and change to a newly created directory
mcd() {
   [ -n "$@" ] && mkdir -p "$@" && cd "$@" || echo "Please name a directory to create."
}

# Functions for quickly adding and jumping to "goto" directories
gt() {
    GT_LIST="$HOME/.config/zsh/gt_list"
    GT_DIR="$(cat "$GT_LIST" | fzf --height=~100% --cycle --preview 'ls {}' --prompt="Searching >_ "\
        --header="Goto directory" --header-first --border=rounded)"
    [ -n "$GT_DIR" ] && cd "$GT_DIR" || echo "Please select a goto directory to navigate to."
}

# Aliases
alias latexmk='latexmk -quiet 1> /dev/null'
alias {vi,vim}='nvim'
alias cat='bat'
alias xr='open_xplr'
alias sysinfo='curl -sL https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash'
alias ll='ls -lh'
alias la='ls -alh'
alias less='less -RFX'
if [ "$(uname)" = "Darwin" ]; then
    alias stat='stat -x'
fi
alias ya='yazi'

# Key bindings
bindkey -s '^k' 'dot_folder_edit\n'
bindkey -s '^e' 'current_folder_edit\n'
bindkey -s '^g' 'gt\n'

# More color and theme related settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="underline"

export BAT_THEME="ansi"

# fzf color settings
export FZF_DEFAULT_OPTS="
    --color=fg:#908caa,bg:#232136,hl:#ea9a97
    --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
    --color=border:#44415a,header:#3e8fb0,gutter:#232136
    --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
"

# Show a greeting message and cheak if dash is the system shell
greet_message=$(<$HOME/.config/zsh/greeting.txt)

case "$(uname)" in
    Darwin)
        if [ "$(readlink "/var/select/sh")" = "/bin/dash" ]; then
            printf "%s\n" "$greet_message"
        else
            printf "%s\n" "$greet_message"
            printf "Please change your system shell\n"
            printf "Run the command:\n"
            printf "sudo ln -sf /bin/dash /private/var/select/sh\n"
        fi
        ;;
    Linux)
        # ask kitty to use wayland
        KITTY_ENABLE_WAYLAND=1
        if [ "$(readlink "/bin/sh")" = "/bin/dash" ]; then
            printf "%s\n" "$greet_message"
        else
            printf "%s\n" "$greet_message"
            printf "Please change your system shell\n"
            printf "Run the command:\n"
            printf "sudo ln -sf /bin/dash /bin/sh\n"
        fi
        ;;
    *)
        printf "Unsupported operating system: $(uname)\n"
        ;;
esac
