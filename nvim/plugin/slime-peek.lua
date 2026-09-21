-- Convenience functions for data exploration with `vim-slime`
return {
    "fasterius/slime-peek.nvim",
    dependencies = "jpalardy/vim-slime",
    keys = {
        { "<localleader>h" },
        { "<localleader>T" },
        { "<localleader>n" },
        { "<localleader>d" },
        { "<localleader>t" },
        { "<localleader>H" },
        { "<localleader>mh" },
        { "<localleader>mT" },
        { "<localleader>mn" },
        { "<localleader>md" },
        { "<localleader>mt" },
        { "<localleader>mH" },
    },
    config = function()
        local peek = require("slime_peek")
        peek.setup({
            use_yaml_language = false,
        })
        -- Word under cursor mappings
        vim.keymap.set("n", "<localleader>h", peek.peek_head)
        vim.keymap.set("n", "<localleader>T", peek.peek_tail)
        vim.keymap.set("n", "<localleader>n", peek.peek_names)
        vim.keymap.set("n", "<localleader>d", peek.peek_dims)
        vim.keymap.set("n", "<localleader>t", peek.peek_types)
        vim.keymap.set("n", "<localleader>H", peek.peek_help)
        -- Motion mappings
        vim.keymap.set("n", "<localleader>mh", peek.peek_head_motion)
        vim.keymap.set("n", "<localleader>mT", peek.peek_tail_motion)
        vim.keymap.set("n", "<localleader>mn", peek.peek_names_motion)
        vim.keymap.set("n", "<localleader>md", peek.peek_dims_motion)
        vim.keymap.set("n", "<localleader>mt", peek.peek_types_motion)
        vim.keymap.set("n", "<localleader>mH", peek.peek_help_motion)
    end,
}
