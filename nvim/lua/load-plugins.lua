-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

-- Prepend runtimepath with path to lazy.nvim
vim.opt.runtimepath:prepend(lazypath)

-- Configuration
local opts = {
    change_detection = {
        notify = false
    }
}

-- Setup lazy.nvim modules
require('lazy').setup('plugins', opts)
