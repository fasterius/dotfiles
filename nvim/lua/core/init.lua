-- Temporary workaround for https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight

require("core.autocommands")
require("core.keymaps")
require("core.options")
require("core.utils")
