# =====================
# Fish shell config file
# ---------------------
# Author: Bo Cao
# Date: Jan 25, 2025
# =====================

# Export variables
# -----------
set -gx PATH "$HOME/.local/bin:$PATH"  # Add local binaries to PATH
set -gx PATH "$HOME/bin:$PATH"
set -gx XDG_CONFIG_HOME "$HOME/.config"  # Set XDG_CONFIG_HOME to ~/.config
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx MPLCONFIGDIR "$HOME/.config/matplotlib"  # Set Matplotlib configuration directory
set -gx EDITOR nvim  # Set default editor to nvim
set -gx LANG en_US.UTF-8  # Set default language to US English
set -gx LC_COLLATE C
set -gx LC_CTYPE zh_CN.UTF-8
set -gx TERM ghostty  # Set terminal type to xterm-256color
set -gx COLORTERM truecolor
set -gx STARDICT_DATA_DIR "$XDG_DATA_HOME"
set -gx FZF_DEFAULT_OPTS "
    --height=50%
    --layout=reverse
    --border=rounded
    --color=fg:#908caa,bg:#232136,hl:#ea9a97
    --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
    --color=border:#44415a,header:#3e8fb0,gutter:#232136
    --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
"

set -gx FZF_TMUX 1
set -gx FZF_TMUX_OPTS "-p"

switch (uname)
    case Darwin
        set -gx PATH "/usr/local/opt/llvm/bin:$PATH"
        set -gx PATH "/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/python/libexec/bin:$PATH"  # Add Homebrew binaries to PATH
        set -gx LDFLAGS "-L/opt/homebrew/opt/openblas/lib"  # Set LDFLAGS for OpenBLAS
        set -gx CPPFLAGS "-I/opt/homebrew/opt/openblas/include"  # Set CPPFLAGS for OpenBLAS
        set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/openblas/lib/pkgconfig"  # Set PKG_CONFIG_PATH for OpenBLAS
        set -gx CPATH /opt/homebrew/include
        set -gx LIBRARY_PATH /opt/homebrew/lib
        set -gx HOMEBREW_BUNDLE_FILE "$HOME/.config/homebrew/Brewfile"
    case Linux
        set -gx XDG_SESSION_TYPE wayland
        set -gx MOZ_ENABLE_WAYLAND 1
        set -gx QT_QPA_PLATFORM "wayland;xcb"
        set -gx XDG_CURRENT_DESKTOP Hyprland
        set -gx XDG_CURRENT_SESSION Hyprland
        set -gx LIBSEAT_BACKEND logind
        set -gx GDK_DPI_SCALE 
        set -gx QT_SCALE_FACTOR 1
        set -gx WLR_DRM_NO_MODIFIERS 1
        set -gx WEBKIT_DISABLE_COMPOSITING_MODE 1
        set -gx http_proxy "http://127.0.0.1:7893"
        set -gx https_proxy $http_proxy
        set -gx ftp_proxy $http_proxy
        set -gx rsync_proxy $http_proxy
        set -gx all_proxy "socks5://127.0.0.1:7893"
end

# Interaction shell settings
# -----------
if status is-interactive
# Using starship as shell prompt
starship init fish | source

# Bindkeys
bind \ce current_folder_edit
bind \cg smt
bind \cx\ce edit_command_buffer

# Aliases
alias ls='lsd'
alias latexmk='latexmk -quiet 1> /dev/null'
alias vi='nvim'
alias vim='nvim'
alias cat='bat'
alias ll='ls -lh'
alias la='ls -alh'
alias less='less -RFX'
if test (uname) = "Darwin"
    alias stat='stat -x'
end

# Greating message
set -U fish_greeting
set greet_message (cat $HOME/.config/zsh/greeting.txt)
printf "%s\n" $greet_message
switch (uname)
    case Darwin
        if not test (readlink -f /var/select/sh) = "/bin/dash"
            printf "Please change your system shell\n"
            printf "Run the command:\n"
            printf "sudo ln -sf /bin/dash /private/var/select/sh\n"
        end
    case Linux
            printf "Please change your system shell\n"
            printf "Run the command:\n"
            printf "sudo ln -sf /bin/dash /private/var/select/sh\n"
end

end
