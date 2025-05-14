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

        -- General mappings
        vim.keymap.set("n", "<localleader>s", "<plug>SlimeMotionSend")
        vim.keymap.set("n", "<localleader>l", "<plug>SlimeLineSend")
        vim.keymap.set("x", "<localleader>v", "<plug>SlimeRegionSend")
        vim.keymap.set("n", "<localleader>c", "<plug>SlimeSendCell")
        vim.keymap.set("n", "<localleader>C", ':SlimeSend0 "\\x03"<CR>')
    end,
}
