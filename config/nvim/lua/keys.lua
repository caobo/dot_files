local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap the key used to leave insert mode
map({ 'n', 'v' }, '<Space>', '<Nop>', opts)
map('i', 'jk', '<ESC>', opts)
map('i', 'jj', '<ESC>:w<ESC>', opts)
map('n', '<leader>s', '<cmd>w<cr>', { desc = "[s]ave file", unpack(opts) })

-- close current buffer and quit nvim if it is the last buffer
local function smart_quit()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    -- save file first
    vim.cmd('write')
    -- close current buffer
    if #buffers == 1 then
        -- If it is the last buffer, quit Neovim
        vim.cmd('quit')
    end
    vim.cmd('bd')
end
map('n', '<leader>q', smart_quit, { desc = "smart [q]uit buffer", unpack(opts) })
map('n', '<leader>Q', '<cmd>xall<cr>', { desc = "[Q]uit all buffers", unpack(opts) })

-- quick access the quickfix list items

map({ 'n' }, ']q', function()
    if #vim.fn.getqflist() == 0 then
        return
    end
    local ok, _ = pcall(vim.cmd.cnext)
    if not ok then
        vim.cmd.cfirst()
    end
    vim.cmd('normal! zz')
end, { desc = "Next quickfix item", unpack(opts) })
map({ 'n' }, '[q', function()
    if #vim.fn.getqflist() == 0 then
        return
    end
    local ok, _ = pcall(vim.cmd.cprev)
    if not ok then
        vim.cmd.clast()
    end
    vim.cmd('normal! zz')
end, { desc = "Prev quickfix item", unpack(opts) })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Remap line move
map("n", "<A-Down>", "<cmd>m .+1<cr>==", opts)
map("n", "<A-Up>", "<cmd>m .-2<cr>==", opts)
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", opts)
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", opts)
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", opts)
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", opts)

-- remap page navigation
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<C-o>", "<C-o>zz", opts)

-- remaps customized paste
map("x", "<leader>p", [["_dP]], opts)

-- duplicate and comment current line
map('n', 'ycc', 'yygccp', { remap = true })

-- format the entire file
local function lsp_formatting()
    local clients = vim.lsp.get_clients()
    local buf_filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    if #clients == 0 then
        return [[gg=G'']]
    end
    for _, client in ipairs(clients) do
        ---@diagnostic disable-next-line: undefined-field
        local filetype = client.config.filetypes
        if filetype and vim.fn.index(filetype, buf_filetype) ~= -1 then
            return vim.lsp.buf.format()
        end
        return [[gg=G'']]
    end
end
map("n", "<leader>mm", lsp_formatting, opts)

-- reload nvim
map("n", "<leader>rl", "<cmd>source $HOME/.config/nvim/init.lua<cr>", opts)
