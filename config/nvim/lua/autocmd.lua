-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ close some filetypes with <q> ]]
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query", -- :InspectTree
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- [[use line comment in C and C++]]
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt_local.commentstring = "// %s" -- Set line comment to //
    end,
})

-- [[ wrap and check for spell in text filetypes ]]
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "markdown", "text", "latex", "tex", "md", "txt" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- [[ create a keymap for build latex files ]]
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "tex" },
    callback = function(event)
        vim.keymap.set(
            "n", "<leader>rp", "<cmd>!latexmk %<cr>",
            { desc = "[r]un tex compiler with [p]dflatex", buffer = event.buf, silent = true }
        )
        vim.keymap.set(
            "n", "<leader>rx", "<cmd>!latexmk -xelatex %<cr>",
            { desc = "[r]un tex compiler with [x]elatex", buffer = event.buf, silent = true }
        )
        vim.keymap.set(
            "n", "<leader>lv", "<cmd>!open %:r.pdf &<cr>",
            { desc = "view pdf file", buffer = event.buf, silent = true }
        )
    end,
})

-- [[ create a keymap for build python files ]]
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "py", "python" },
    callback = function(event)
        vim.keymap.set(
            'n', '<leader>rp', '<cmd>!python %<cr>',
            { desc = "[r]un [pjython script", buffer = event.buf, silent = true }
        )
    end,
})

-- [[ create a keymap for compile c and cpp files ]]
vim.api.nvim_create_autocmd('FileType', {
    pattern = { "c", "cpp" },
    callback = function(event)
        vim.keymap.set(
            'n', '<leader>rp',
            '<cmd>! clang -o %:r.out % -lm -pthread -fvectorize -fslp-vectorize -fstrict-aliasing -ffast-math -flto -O2 -march=native -Wall -Werror<cr>',
            { desc = "[r]un com[p]iler", buffer = event.buf, silent = true }
        )
    end,
})

-- [[ auto restart yabai sand skhd after saving yabairc and skhdrc ]]
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "yabairc" },
    command = "!yabai --restart-service",
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "skhdrc" },
    command = "!skhd --restart-service",
})

-- [[ LSP related keymaps and settings ]]
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local map = vim.keymap.set
        local opts = { buffer = event.buf, remap = false }
        map("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Goto definition (lsp)", unpack(opts) })
        vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.HINT]  = " ",
                    [vim.diagnostic.severity.ERROR] = "✘",
                    [vim.diagnostic.severity.INFO]  = "◉",
                    [vim.diagnostic.severity.WARN]  = "ⓘ "
                }
            },
        })
    end
})
