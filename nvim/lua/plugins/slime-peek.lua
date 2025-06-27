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
    },
    config = function()
        local peek = require("slime-peek")
        peek.setup({
            use_yaml_language = false,
        })
        vim.keymap.set("n", "<localleader>h", peek.peek_head)
        vim.keymap.set("n", "<localleader>T", peek.peek_tail)
        vim.keymap.set("n", "<localleader>n", peek.peek_names)
        vim.keymap.set("n", "<localleader>d", peek.peek_dimensions)
        vim.keymap.set("n", "<localleader>t", peek.peek_types)
        vim.keymap.set("n", "<localleader>H", peek.peek_help)
    end,
}
