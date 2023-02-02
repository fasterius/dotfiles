return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',     -- Code context
        'nvim-treesitter/nvim-treesitter-textobjects', -- Text objects
        'JoosepAlviste/nvim-ts-context-commentstring'  -- Context-based comments
    },
    config = function()

        require('nvim-treesitter.configs').setup({

            -- Languages to always be installed
            ensure_installed = {
                'bash',
                'help',
                'lua',
                'markdown',
                'markdown_inline',
                'python',
                'r',
                'vim',
                'yaml'
            },

            -- Context-based commenting with `nvim-ts-context-commentstring`
            context_commentstring = {
                enable = true
            },

            -- General settings
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection    = '<C-Space>',
                    node_incremental  = '<C-Space>',
                    scope_incremental = '<C-s>',
                    node_decremental  = '<C-Backspace>',
                }
            },

            -- Settings for additional text objects
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Jump forward to textobj
                    keymaps = {
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true, -- Add jumps to jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    }
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    }
                }
            }
        })

        -- Add underline to Context bar
        vim.cmd [[ hi TreesitterContextBottom gui=underline guisp=Grey ]]

    end
}
