-- [[ opts.lua ]]
local opt = vim.opt

-- [[ Setting options ]]
-- [[ Editor ]]
opt.autochdir = true
opt.mouse = 'a'        -- enable mouse mode
opt.clipboard = "unnamedplus"
opt.breakindent = true -- Enable break indent
opt.wrap = true
opt.number = true
opt.numberwidth = 3
opt.relativenumber = true -- bool: Show relative line numbers
opt.signcolumn = 'yes:1' -- Keep signcolumn on by default
opt.fillchars = 'eob: '
opt.updatetime = 100   -- Decrease update time
opt.timeout = true
opt.timeoutlen = 300
opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
opt.hidden = true
opt.spelllang = { 'en', 'cjk' }
opt.cmdheight = 0
opt.smartindent = true
opt.swapfile = false
opt.listchars = { -- see hidden chars and their colors
    tab = '| ',
    eol = '↲',
    -- eol = '¬',
    trail = '·',
    -- space = '␣',
}
opt.list = true
-- opt.statuscolumn = "%s%l %r"
opt.inccommand = 'split'

-- [[ Context ]]
opt.colorcolumn = '120'   -- str:  Show col for max line length
opt.scrolloff = 8         -- int:  Min num lines of context
opt.showcmd = true

-- [[ Filetypes ]]
opt.encoding = 'utf8'     -- str:  String encoding to use
opt.fileencoding = 'utf8' -- str:  File encoding to use

-- [[ Search ]]
opt.ignorecase = true -- bool: Ignore case in search patterns
opt.smartcase = true  -- bool: Override ignorecase if search contains capitals
opt.incsearch = true  -- bool: Use incremental search
opt.hlsearch = true   -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true -- bool: Use spaces instead of tabs
opt.shiftwidth = 4   -- num:  Size of an indent
opt.softtabstop = 4  -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4      -- num:  Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true -- bool: Place new window to right of current one

-- [[ Appearance ]]
opt.syntax = "ON" -- str:  Allow syntax highlighting
opt.cursorline = true
opt.cursorlineopt = "number"
opt.termguicolors = true -- bool: If term supports ui color then enable
opt.winborder = 'rounded'

-- [[ Undo tree ]]
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
