--[[ the mega setting files for nvim ]]
-- init.lua file
-- author: Bo Cao
-- date: May 28, 2023
-- --------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- IMPORTS
require('plugs')
require('opts')
require('keys')
require('autocmd')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
