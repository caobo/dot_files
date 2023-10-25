-- load plugins
--
local status_ok, nvim_autopairs = pcall(require, "nvim-autopairs")

if not status_ok then
  return
end

nvim_autopairs.setup({
    disable_filetype = { "TelescopePrompt" , "vim" },
}) -- Add this line

local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rule(Rule("$$","$$","tex", "latex"))

-- you can use some built-in conditions

local cond = require('nvim-autopairs.conds')

npairs.add_rules({
  Rule("\\(", "\\)",{"tex", "latex"})
    -- don't add a pair if the next character is %
    :with_pair(cond.not_after_regex("%%"))
  }
)
npairs.add_rules({
  Rule("\\[", "\\]",{"tex", "latex"})
    -- don't add a pair if the next character is %
    :with_pair(cond.not_after_regex("%%"))
  }
)
