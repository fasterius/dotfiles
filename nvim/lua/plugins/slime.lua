-- An all-purpose REPL for sending code to a terminal
return {
    "jpalardy/vim-slime",
    keys = {
        { "<localleader>C" },
        { "<localleader>P" },
        { "<localleader>c" },
        { "<localleader>l" },
        { "<localleader>r" },
        { "<localleader>s" },
        { "<localleader>v" },
    },
    config = function()
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

        -- General mappings (simple)
        vim.keymap.set("n", "<localleader>l", "<plug>SlimeLineSend")
        vim.keymap.set("n", "<localleader>s", "<plug>SlimeMotionSend")
        vim.keymap.set("n", "<localleader>C", ':SlimeSend0 "\\x03"<CR>')
        vim.keymap.set("n", "<localleader>q", ':SlimeSend0 "q"<CR>')
        vim.keymap.set("n", "<localleader>r", ':SlimeSend0 "\\n\\n"<CR>')

        -- General mappings (also send two newlines to properly finish Python
        -- code; not needed for other languages, but doesn't do anything
        -- either). The `SlimeMotionSend` command cannot be sent like this
        -- because it interferes with the operator-pending mode.
        vim.keymap.set("n", "<localleader>c", '<Plug>SlimeSendCell<Cmd>SlimeSend0 "\\n\\n"<CR>')
        vim.keymap.set("x", "<localleader>v", '<plug>SlimeRegionSend<Cmd>SlimeSend0 "\\n\\n"<CR>')
    end,
}
