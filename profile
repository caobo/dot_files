# Export global environment variables
# --------------------
export PATH="$HOME/.local/bin:$PATH"  # Add local binaries to PATH
export XDG_CONFIG_HOME="$HOME/.config"  # Set XDG_CONFIG_HOME to ~/.config
export MPLCONFIGDIR="$HOME/.config/matplotlib"  # Set Matplotlib configuration directory
export EDITOR=nvim  # Set default editor to nvim
export LANG=en_US.UTF-8  # Set default language to US English
export TERM=xterm-256color  # Set terminal type to xterm-256color

if [ "$(uname)" = "Darwin" ]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/python/libexec/bin:$PATH"  # Add Homebrew binaries to PATH
    export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"  # Set LDFLAGS for OpenBLAS
    export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"  # Set CPPFLAGS for OpenBLAS
    export PKG_CONFIG_PATH="/opt/homebrew/opt/openblas/lib/pkgconfig"  # Set PKG_CONFIG_PATH for OpenBLAS
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
