-- Add operators for substitutions
vim.pack.add({
    "https://github.com/gbprod/substitute.nvim",
})
require("substitute").setup()

-- Substitute
vim.keymap.set("n", "s", require("substitute").operator)
vim.keymap.set("x", "s", require("substitute").visual)
vim.keymap.set("n", "ss", require("substitute").line)
vim.keymap.set("n", "S", require("substitute").eol)

-- Substitute over range
vim.keymap.set("n", "<leader>s", require("substitute.range").operator)
vim.keymap.set("x", "<leader>s", require("substitute.range").visual)
vim.keymap.set("n", "<leader>ss", require("substitute.range").word)
