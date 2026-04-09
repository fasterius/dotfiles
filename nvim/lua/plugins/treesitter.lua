-- Fast syntax parsing
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context", -- Code context
        "nvim-treesitter/nvim-treesitter-textobjects", -- Text objects
        "JoosepAlviste/nvim-ts-context-commentstring", -- Context-based comments
    },
    config = function()
        require("nvim-treesitter").setup()

        require("nvim-treesitter").install({
            "bash",
            "dockerfile",
            "javascript",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "r",
            "toml",
            "vim",
            "vimdoc",
            "yaml",
        })

        -- Enable highlighting and indentation support
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start)
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- Add underline to Context bar
        vim.cmd([[ hi TreesitterContextBottom gui=underline guisp=Grey ]])

        -- Make `ts_context_commentstring` work with native Neovim commenting;
        -- see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#native-commenting-in-neovim-010
        -- for details.
        require("ts_context_commentstring").setup({
            enable_autocmd = false,
        })
        local get_option = vim.filetype.get_option
        vim.filetype.get_option = function(filetype, option)
            return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
                or get_option(filetype, option)
        end
    end,
}
