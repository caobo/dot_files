# Export global environment variables
# --------------------
export PATH="$HOME/.local/bin:$PATH"  # Add local binaries to PATH
export XDG_CONFIG_HOME="$HOME/.config"  # Set XDG_CONFIG_HOME to ~/.config
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export MPLCONFIGDIR="$HOME/.config/matplotlib"  # Set Matplotlib configuration directory
export EDITOR=nvim  # Set default editor to nvim
export LANG=en_US.UTF-8  # Set default language to US English
export TERM=xterm-256color  # Set terminal type to xterm-256color
export TERMINAL=kitty
if [ "$(uname)" = "Darwin" ]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/python/libexec/bin:$PATH"  # Add Homebrew binaries to PATH
    export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"  # Set LDFLAGS for OpenBLAS
    export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"  # Set CPPFLAGS for OpenBLAS
    export PKG_CONFIG_PATH="/opt/homebrew/opt/openblas/lib/pkgconfig"  # Set PKG_CONFIG_PATH for OpenBLAS
    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
    export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"
elif [ "$(uname)" = "Linux" ]; then
    export XDG_SESSION_TYPE=wayland
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM="wayland;xcb"
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_CURRENT_SESSION=Hyprland
    export LIBSEAT_BACKEND=logind
    export GDK_DPI_SCALE=1
    export QT_SCALE_FACTOR=1
    export WLR_DRM_NO_MODIFIERS=1
fi
STARDICT_DATA_DIR="$XDG_DATA_HOME"
