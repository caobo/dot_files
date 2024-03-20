local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap the key used to leave insert mode
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map('i', 'jk', '<ESC>', opts)
map('i', 'jj', '<ESC>:w<ESC>', opts)
map('n', '<leader>s', '<cmd>w<cr>', opts)
map('n', '<leader>q', '<cmd>x<cr>', opts)

-- settings for splitting pane
map('n', '<leader>sv', '<C-w>v', opts)
map('n', '<leader>sh', '<C-w>h', opts)

map({'n'}, '<C-h>', '<C-w>h', opts)
map({'n'}, '<C-l>', '<C-w>l', opts)
map({'n'}, '<C-j>', '<C-w>j', opts)
map({'n'}, '<C-k>', '<C-w>k', opts)

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true})
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Remap line move
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- remap page navigation
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- remaps customized paste
map("x", "<leader>p", [["_dP]], opts)

-- reload nvim
map("n", "<leader>rl", "<cmd>source $HOME/.config/nvim/init.lua<cr>", opts)
