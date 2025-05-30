# =====================
# Zsh shell config file
# ---------------------
# author: Bo Cao
# create date: May 28, 2023
# ---------------------
# version: 0.1
# =====================

# zap plugin manager settings
# --------------------
# Created by Zap installer
ZAP_DIR="${XDG_DATA_HOME:-HOME/.local/share}/zap" 
if [ -f "$ZAP_DIR/zap.zsh" ]; then
    source "$ZAP_DIR/zap.zsh"
else
    echo "zap is not installed, now will install it."
    mkdir -p "$ZAP_DIR"
    git clone --depth 1 https://github.com/zap-zsh/zap.git "$ZAP_DIR" &> /dev/null
    source "$ZAP_DIR/zap.zsh"
fi

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zdharma-continuum/fast-syntax-highlighting"

# Start starship prompt
eval "$(starship init zsh)"

# load modules
zmodload zsh/complist
autoload -Uz compinit && compinit

# Load and initialise completion system
HISTFILE="$HOME/.zsh_history"
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt auto_menu menu_complete
setopt auto_param_slash
unsetopt prompt_sp
SAVEHIST=1000
HISTSIZE=999
HISTDUP=erase
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
# Enable emacs keybinds
# bindkey -e

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Autocompletion using arrow keys (based on history)
bindkey '\C-p' history-search-backward
bindkey 'C-n' history-search-forward

bindkey '\C-y' autosuggest-accept

# User configuration
# --------------------
LESS=-RFX  # Set LESS options for displaying man pages
export MANPAGER="/usr/bin/less -R --use-color -Ddg -Du+y"

# Enable fzf fuzzy completion
[ -f "$HOME/.config/zsh/fzf.zsh" ] && source "$HOME/.config/zsh/fzf.zsh"

# Custom functions
# --------------------

# Create and change to a newly created directory
take() {
   [ -n "$@" ] && mkdir -p "$@" && cd "$@" || echo "Please name a directory to create."
}

sw() {
    smt $(tmux ls | awk -F : '{print $1}' | fzf)
}

# Aliases
alias ls='lsd'
alias latexmk='latexmk -quiet 1> /dev/null'
alias {vi,vim}='nvim'
alias cat='bat'
alias ll='lsd -lh'
alias la='lsd -alh'
alias less='less -RFX'
if [ "$(uname)" = "Darwin" ]; then
    alias stat='stat -x'
fi
alias nom='nom --config-path $XDG_CONFIG_HOME/nom/config.yml'
alias so='source $ZSHRC'

# unbind keys
bindkey -r '\C-k'
bindkey -r '\C-e'
bindkey -r '\C-g'

# Key bindings
bindkey -s '\C-k' 'dot_folder_edit\n'
bindkey -s '\C-e' 'current_folder_edit\n'
bindkey -s '\C-g' 'smt\n'

# More color and theme related settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="underline"

# fzf color settings with rose-pine theme
# export FZF_DEFAULT_OPTS="
#     --height=50%
#     --layout=reverse
#     --border=rounded
#     --color=fg:#908caa,bg:#232136,hl:#ea9a97
#     --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
#     --color=border:#44415a,header:#3e8fb0,gutter:#232136
#     --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
#     --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
# "

# fzf color with catppuccin theme
export FZF_DEFAULT_OPTS="
--height=60%
--layout=reverse
--border=rounded
--margin=5%,2%,2%,5% 
--multi
--preview-window=60%,border-double
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=border:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=selected-bg:#45475a
"

# Show a greeting message and cheak if dash is the system shell
greet_message=$(<$HOME/.config/zsh/greeting.txt)
printf "%s\n" "$greet_message"
case "$(uname)" in
    Darwin)
        if [ ! "$(readlink -f "/var/select/sh")" = "/bin/dash" ]; then
            printf "Please change your system shell\n"
            printf "Run the command:\n"
            printf "sudo ln -sf /bin/dash /private/var/select/sh\n"
        fi
        ;;
    Linux)
        # ask kitty to use wayland
        KITTY_ENABLE_WAYLAND=1
        if not [ ! "$(readlink -f "/bin/sh")" = "/usr/bin/dash" ]; then
            printf "Please change your system shell\n"
            printf "Run the command:\n"
            printf "sudo ln -sf /usr/bin/dash /bin/sh\n"
        fi
        ;;
    *)
        printf "Unsupported operating system: $(uname)\n"
        ;;
esac
