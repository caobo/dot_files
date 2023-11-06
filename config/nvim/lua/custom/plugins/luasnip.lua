return{
    "L3MON4D3/LuaSnip", -- Snippet Engine
    event ={ 'BufReadPost', 'BufNewFile'},
    config = function ()
        local luasnip = require("luasnip")
        luasnip.config.set_config({ -- Setting LuaSnip config
            -- Enable autotriggered snippets
            enable_autosnippets = true,
            -- Use Tab (or some other key if you prefer) to trigger visual selection
            -- store_selection_keys = "<Tab>",
        })
        -- Load snippets
        require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/lua/custom/snippets"})
        require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/lua/custom/snippets"})
        require("luasnip.loaders.from_snipmate").lazy_load()
    end
}
