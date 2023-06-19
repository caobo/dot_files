local status_ok, luasnip = pcall(require, "luasnip")

if not status_ok then
  return
end

luasnip.config.set_config({ -- Setting LuaSnip config
  -- Enable autotriggered snippets
  enable_autosnippets = true,
  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- Load snippets
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/lua/custom/snippets"})
require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/lua/custom/snippets"})
require("luasnip.loaders.from_snipmate").lazy_load()
