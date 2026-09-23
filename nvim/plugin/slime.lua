-- An all-purpose REPL for sending code to a terminal with `vim-slime` together
-- with convenience functions for data exploration with `slime-peek`
vim.pack.add({
    "https://github.com/jpalardy/vim-slime",
    "https://github.com/fasterius/slime-peek.nvim",
})

------------------------------- `vim-slime` -----------------------------------

-- Use Tmux as target
vim.g.slime_target = "tmux"

-- Pre-fill configuration with default socket and pane 1
vim.g.slime_default_config = {
    socket_name = "default",
    target_pane = "1",
}

-- Do not use default mappings
vim.api.nvim_set_var("slime_no_mappings", 1)

-- Use triple brackets as cell delimiters
vim.g.slime_cell_delimiter = "```"

-- Use bracketed paste mode to help with Python indentation; more
-- details at https://cirw.in/blog/bracketed-paste
vim.g.slime_bracketed_paste = 1

-- General mappings
vim.keymap.set("n", "<localleader>l", "<plug>SlimeLineSend")
vim.keymap.set("n", "<localleader>s", "<plug>SlimeMotionSend")
vim.keymap.set("n", "<localleader>c", "<Plug>SlimeSendCell")
vim.keymap.set("x", "<localleader>v", "<plug>SlimeRegionSend")
vim.keymap.set("n", "<localleader>C", ':SlimeSend0 "\\x03"<CR>')
vim.keymap.set("n", "<localleader>q", ':SlimeSend0 "q"<CR>')
vim.keymap.set("n", "<localleader>r", ':SlimeSend0 "\\n\\n"<CR>')

------------------------------- `slime-peek` ----------------------------------

-- Use chunk-based language specification
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
