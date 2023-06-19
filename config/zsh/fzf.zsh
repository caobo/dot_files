# Setup fzf
# ---------
if [ $(uname) = "Darwin" ]; then
    if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
        PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
    fi
fi

# Auto-completion
# ---------------
if [ $(uname) = "Darwin" ]; then
    [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
fi
if [ $(uname) = "Linux" ]; then
    source "/usr/share/fzf/completion.zsh" 2> /dev/null
fi


# Key bindings
# ------------
# if [ $(uname) = "Darwin" ]; then
#     source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
# fi
# if [ $(uname) = "Linux" ]; then
#     source "/usr/share/fzf/key-bindings.zsh"
# fi
