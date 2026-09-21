-- Add operators for substitutions
-- No lazy loading; used to be lazily loaded on keybinds
vim.pack.add({
    "https://github.com/gbprod/substitute.nvim",
})

-- Substitute
local substitute = require("substitute")
vim.keymap.set("n", "s", substitute.operator, { noremap = true })
vim.keymap.set("x", "s", substitute.visual, { noremap = true })
vim.keymap.set("n", "ss", substitute.line, { noremap = true })
vim.keymap.set("n", "S", substitute.eol, { noremap = true })

-- Substitute over range
local range = require("substitute.range")
vim.keymap.set("n", "<leader>s", range.operator, { noremap = true })
vim.keymap.set("x", "<leader>s", range.visual, { noremap = true })
vim.keymap.set("n", "<leader>ss", range.word, { noremap = true })
