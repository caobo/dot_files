# jovial theme colors mapping
# use `sheet:color` plugin function to see color table
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Visual-effects
JOVIAL_PALETTE=(
    # hostname
    host '%F{111}'
    # common user name
    user '%F{259}'
    # only root user
    root '%B%F{203}'
    # current work dir path
    path '%B%F{111}%}'
    # git status info (dirty or clean / rebase / merge / cherry-pick)
    git '%F{259}'
    # virtual env activate prompt for python
    venv '%F{105}'
    # current time when prompt render, pin at end-of-line
    time '%F{254}'
    # elapsed time of last command executed
    elapsed '%F{222}'
    # exit code of last command
    exit.mark '%F{008}'
    exit.code '%B%F{199}'
    # 'conj.': short for 'conjunction', like as, at, in, on, using
    conj. '%F{102}'
    # shell typing area pointer
    # typing '%F{008}'
    typing '%F{255}'
    # for other common case text color
    normal '%F{008}'
    success '%F{042}'
    error '%F{197}'
)

JOVIAL_AFFIXES=(
    host.prefix            '${JOVIAL_PALETTE[normal]}['
    # hostname/username use `Prompt-Expansion` syntax in default
    # but you can override it with simple constant string
    hostname               '${(%):-%m}'
    # hostname               'ᕕ( ᐛ )ᕗ'
    # hostname               '≧◡≦'
    host.suffix            '${JOVIAL_PALETTE[normal]}] ${JOVIAL_PALETTE[conj.]}as'
    # hostname               '╹‿╹'
    host.suffix            '${JOVIAL_PALETTE[normal]}] ${JOVIAL_PALETTE[conj.]}as'

    user.prefix            ' '
    username               '${(%):-%n}'
    user.suffix            ' ${JOVIAL_PALETTE[conj.]}in'

    path.prefix            ' '
    current-dir            '%~'
    path.suffix            ''

    dev-env.prefix         ' '
    dev-env.suffix         ''

    git-info.prefix        ' ${JOVIAL_PALETTE[conj.]}on ${JOVIAL_PALETTE[normal]}('
    git-info.suffix        '${JOVIAL_PALETTE[normal]})'

    venv.prefix            '${JOVIAL_PALETTE[normal]}('
    venv.suffix            '${JOVIAL_PALETTE[normal]}) '

    exec-elapsed.prefix    ' ${JOVIAL_PALETTE[elapsed]}~'
    exec-elapsed.suffix    ' '

    exit-code.prefix       ' ${JOVIAL_PALETTE[exit.mark]}exit:'
    exit-code.suffix       ' '

    current-time.prefix    ' '
    current-time.suffix    ' '
)

JOVIAL_PROMPT_ORDER=(
    host
    user
    path
    dev-env
    git-info
)

JOVIAL_SYMBOL=(
    # corner.top    '╭─'
    # corner.bottom '╰─'
    corner.top    ''
    corner.bottom ''
    git.dirty ' ✘'
    git.clean ' ✔'
    arrow '─➤'
    arrow.git-clean '(๑˃̵ᴗ˂̵)و'
    arrow.git-dirty '(ﾉ˚Д˚)ﾉ'
)
