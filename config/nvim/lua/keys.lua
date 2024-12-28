local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap the key used to leave insert mode
map({ 'n', 'v' }, '<Space>', '<Nop>', opts)
map('i', 'jk', '<ESC>', opts)
map('i', 'jj', '<ESC>:w<ESC>', opts)
map('n', '<leader>s', '<cmd>w<cr>', opts)

-- close current buffer and quit nvim if it is the last buffer
local function smart_quit()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    -- save file first
    vim.cmd('write')
    -- close current buffer
    if #buffers == 1 then
        -- If it is the last buffer, quit Neovim
        vim.cmd('quit')
    else
        -- Otherwise, delete the current buffer and switch to the next one
        vim.cmd('bd')
    end
end
map('n', '<leader>q', smart_quit, opts)

-- settings for splitting pane
map('n', '<leader>sv', '<C-w>v', opts)
map('n', '<leader>sh', '<C-w>h', opts)

map({'n'}, '<C-j>', '<cmd>cnext<cr>zz', opts)
map({'n'}, '<C-k>', '<cmd>cprev<cr>zz', opts)

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Remap line move
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" },opts)
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" },opts)
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" },opts)
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" },opts)
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" },opts)
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" },opts)

-- remap page navigation
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- remaps customized paste
map("x", "<leader>p", [["_dP]], opts)
map({"n", "v"}, "<leader>d", [["_d]], opts)

-- format the entire file
map("n", "<leader>mm", "gg=G''", opts)

-- reload nvim
map("n", "<leader>rl", "<cmd>source $HOME/.config/nvim/init.lua<cr>", opts)
