local M = {"windwp/nvim-autopairs"}

M.event ="InsertEnter"

function M.config()
    local autopairs = require("nvim-autopairs")

    autopairs.setup {
        check_ts = true, -- treesitter integration
        disable_filetype = { "TelescopePrompt" },
    }

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
        return
    end
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})

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
    })
end

return M
