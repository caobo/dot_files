# Export global environment variables
# --------------------
export PATH="$HOME/.local/bin:$PATH"  # Add local binaries to PATH
export PATH="$HOME/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"  # Set XDG_CONFIG_HOME to ~/.config
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export MPLCONFIGDIR="$HOME/.config/matplotlib"  # Set Matplotlib configuration directory
export EDITOR=nvim  # Set default editor to nvim
export LANG=en_US.UTF-8  # Set default language to US English
export LC_COLLATE=C
export LC_CTYPE=zh_CN.UTF-8
export TERM=ghostty
export COLORTERM truecolor
export STARDICT_DATA_DIR="$XDG_DATA_HOME"
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p"

case "$(uname)" in
    Darwin)
        export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
        export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/python/libexec/bin:$PATH"  # Add Homebrew binaries to PATH
        export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"  # Set LDFLAGS for OpenBLAS
        export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"  # Set CPPFLAGS for OpenBLAS
        export PKG_CONFIG_PATH="/opt/homebrew/opt/openblas/lib/pkgconfig"  # Set PKG_CONFIG_PATH for OpenBLAS
        export CPATH=/opt/homebrew/include
        export LIBRARY_PATH=/opt/homebrew/lib
        export HOMEBREW_BUNDLE_FILE="$HOME/.config/homebrew/Brewfile"
    ;;
    Linux)
        export XDG_SESSION_TYPE=wayland
        export MOZ_ENABLE_WAYLAND=1
        export QT_QPA_PLATFORM="wayland;xcb"
        export XDG_CURRENT_DESKTOP=Hyprland
        export XDG_CURRENT_SESSION=Hyprland
        export LIBSEAT_BACKEND=logind
        export GDK_DPI_SCALE=
        export QT_SCALE_FACTOR=1
        export WLR_DRM_NO_MODIFIERS=1
        export WEBKIT_DISABLE_COMPOSITING_MODE=1
        export http_proxy="http://127.0.0.1:7893"
        export https_proxy=$http_proxy
        export ftp_proxy=$http_proxy
        export rsync_proxy=$http_proxy
        export all_proxy="socks5://127.0.0.1:7893"
    ;;
esac
