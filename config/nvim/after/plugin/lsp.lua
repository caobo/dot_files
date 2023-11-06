local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    lsp.default_keymaps({buffer = bufnr})
end)

-- lsp-server config
lsp.setup_servers({'lua_ls', 'pyright','texlab'})

-- vim.diagnostic.config({
--     virtual_text = true
-- })

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'lua_ls','pyright','texlab'},
    handlers = {
        lsp.default_setup,
    },
})

local lua_opts = lsp.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)
  require('mason-lspconfig').setup({
    handlers = {
      lsp.default_setup,
      lua_ls = function()
        require('lspconfig').lua_ls.setup(lua_opts)
      end,
    },
  })
