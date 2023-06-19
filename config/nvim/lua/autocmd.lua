-- [[ terminal settings ]]
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = 'startinsert',
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  command = "checktime",
})

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

-- [[ wrap and check for spell in text filetypes ]]
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" ,"latex", "tex", "md", "txt"},
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- [[ create a keymap for build latex files ]]
vim.api.nvim_create_autocmd('FileType',{
    pattern = {"tex"},
    callback = function (event)
        vim.keymap.set("n", "<leader>ll", "<cmd>!latexmk %<cr>", {buffer = event.buf, silent = true})
        vim.keymap.set("n", "<leader>lx", "<cmd>!latexmk -xelatex %<cr>", {buffer = event.buf, silent = true})
    end,
})

-- [[ create a keymap for build python files ]]
vim.api.nvim_create_autocmd('FileType',{
    pattern = {'py','python'},
    callback = function (event)
        vim.keymap.set('n', '<leader>bb', '<cmd>!python %<cr>', {buffer = event.buf, silent = true})
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

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "zshrc" },
  command = "!source ~/.zshrc",
})

-- vim.api.nvim_command "sign define DiagnosticSignError text=● texthl=DiagnosticSignError"
-- vim.api.nvim_command "sign define DiagnosticSignWarn text=● texthl=DiagnosticSignWarn"
-- vim.api.nvim_command "sign define DiagnosticSignInfo text=● texthl=DiagnosticSignInfo"
-- vim.api.nvim_command "sign define DiagnosticSignHint text=● texthl=DiagnosticSignHint"
