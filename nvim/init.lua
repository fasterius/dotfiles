-- NeoVim configuration
-- Author: Erik Fasterius <erik dot fasterius at outlook dot com>
-- URL:    https://github.com/fasterius/dotfiles

require('autocommands')
require('keymaps')
require('options')

-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim modules
require('lazy').setup('plugins')
