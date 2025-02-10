-- =====================
-- The init configuration file for neovim
-- ---------------------
-- author: Bo Cao
-- create date: May 5, 2023
-- ---------------------
-- version: 0.2
-- modified date: Feb 8, 2025
-- =====================

-- Set leader key to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Imports configurations
require('opts')
require('keys')
require('autocmd')
require('plugs')
