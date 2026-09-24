-- Set leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Store relative line number movement larger than 1 in the jumplist
-- Move by visual lines instead of physical lines
vim.keymap.set(
    "n",
    "j",
    [[v:count ? (v:count > 1 ? "m'" . v:count : '') . 'j' : 'gj']],
    { expr = true }
)
vim.keymap.set(
    "n",
    "k",
    [[v:count ? (v:count > 1 ? "m'" . v:count : '') . 'k' : 'gk']],
    { expr = true }
)
vim.keymap.set("n", "0", "g0")
vim.keymap.set("n", "$", "g$")

--  Keep selection after indenting in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Center cursor in screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
