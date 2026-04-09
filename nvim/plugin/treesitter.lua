-- Fast syntax parsing

-- Automatically run TSUpdate when updating the plugin
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    "https://github.com/nvim-treesitter/nvim-treesitter-context", -- Code context
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", -- Text objects
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring", -- Context-based comments
})

-- build = function()
--     pcall(require("nvim-treesitter.install").update({ with_sync = true }))
-- end,

require("nvim-treesitter").setup({

    -- Languages to always be installed
    ensure_installed = {
        "bash",
        "dockerfile",
        "javascript",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "r",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    -- General settings
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = {
            "markdown", -- Treesitter is worse than Vim list formatting
        },
    },

    -- Settings for additional text objects
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Jump forward to textobj
            keymaps = {
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- Add jumps to jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
})

-- Add underline to Context bar
vim.cmd([[ hi TreesitterContextBottom gui=underline guisp=Grey ]])
