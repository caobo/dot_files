-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- note: remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- in this case, we create a function that lets us more easily define mappings specific
    -- for lsp related items. it sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'lsp: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
    -- nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
    nmap('gd', vim.lsp.buf.declaration, '[g]oto [d]eclaration')
    -- nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
    -- nmap('gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')
    -- nmap('<leader>d', vim.lsp.buf.type_definition, 'type [d]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')
    -- see `:help k` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'hover documentation')
    -- nmap('<c-k>', vim.lsp.buf.signature_help, 'signature documentation')
    -- lesser used lsp functionality
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[w]orkspace [l]ist folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
local servers = {
    -- clangd = {},
    -- gopls = {},
    pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    texlab = {},
}


-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
