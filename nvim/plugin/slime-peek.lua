-- Convenience functions for data exploration with `vim-slime`
vim.pack.add({
    "https://github.com/fasterius/slime-peek.nvim",
    "https://github.com/jpalardy/vim-slime",
})
vim.g.slime_peek = {
    use_yaml_language = false,
}

-- Word under cursor mappings
vim.keymap.set("n", "<localleader>h", require("slime_peek").peek_head)
vim.keymap.set("n", "<localleader>T", require("slime_peek").peek_tail)
vim.keymap.set("n", "<localleader>n", require("slime_peek").peek_names)
vim.keymap.set("n", "<localleader>d", require("slime_peek").peek_dims)
vim.keymap.set("n", "<localleader>t", require("slime_peek").peek_types)
vim.keymap.set("n", "<localleader>H", require("slime_peek").peek_help)

-- Motion mappings
vim.keymap.set("n", "<localleader>mh", require("slime_peek").peek_head_motion)
vim.keymap.set("n", "<localleader>mT", require("slime_peek").peek_tail_motion)
vim.keymap.set("n", "<localleader>mn", require("slime_peek").peek_names_motion)
vim.keymap.set("n", "<localleader>md", require("slime_peek").peek_dims_motion)
vim.keymap.set("n", "<localleader>mt", require("slime_peek").peek_types_motion)
vim.keymap.set("n", "<localleader>mH", require("slime_peek").peek_help_motion)
