-- Fuzzy finding with Telescope
return {
    'nvim-telescope/telescope.nvim',
    branch       = '0.1.x',
    keys = {
        '<leader>ff',
        '<leader>fg',
        '<leader>fb',
        '<leader>sg',
        '<leader>st',
        '<leader>sw',
        '<leader>sd',
        '<leader>sh',
        '<leader>si',
        '<leader>/' ,
        '<leader>ds',
        '<leader>ws',
        'gr'
    },
    dependencies = {
        'nvim-lua/plenary.nvim',

        -- Fuzzy Finder algorithm which dependencies local dependencies to be
        -- built (only load if `make` is available)
        { 'nvim-telescope/telescope-fzf-native.nvim',
            build  = 'make',
            cond = vim.fn.executable 'make' == 1
        },
    },
    config = function()

        local actions = require('telescope.actions')
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        -- Disable scrolling inside preview windows
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                        -- Make a single <Esc> exit Telescope
                        ['<Esc>'] = actions.close,
                        -- Send selected/whole list to quickfix list
                        ['<C-q>'] = actions.smart_send_to_qflist,
                    }
                }
            }
        }

        -- Change colour of search results
        -- TODO: don't hard-code
        vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#268bd2' })

        -- Enable telescope fzf native (if installed)
        pcall(require('telescope').load_extension, 'fzf')

        -- Functions for keymaps
        local builtin = require('telescope.builtin')
        local function _live_grep()
            builtin.live_grep { cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }
        end
        local function _grep_string()
            builtin.grep_string { cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }
        end

        -- Finding files
        vim.keymap.set('n', '<leader>fg', builtin.git_files,                     { desc = '[F]ind files inside [G]it repository'            })
        vim.keymap.set('n', '<leader>ff', builtin.find_files,                    { desc = '[F]ind [F]iles in the current working directory' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers,                       { desc = '[F]ind existing [B]uffers'                       })

        -- Searching
        vim.keymap.set('n', '<leader>sg', _live_grep,                            { desc = "[S]earch inside [G]it repository "             })
        vim.keymap.set('n', '<leader>sw', _grep_string,                          { desc = '[S]earch current [W]ord inside Git repository' })
        vim.keymap.set('n', '<leader>sh', builtin.help_tags,                     { desc = '[S]earch [H]elp'                               })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics,                   { desc = '[S]earch [D]iagnostics'                        })
        vim.keymap.set('n', '<leader>si', builtin.highlights,                    { desc = '[S]earch h[I]ghlights'                         })
        vim.keymap.set('n', '<leader>/',  builtin.current_buffer_fuzzy_find,     { desc = '[/] Fuzzily search in current buffer]'         })

        -- LSP
        vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols,          { desc = '[D]ocument [S]ymbols'  })
        vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
        vim.keymap.set('n', 'gr',         builtin.lsp_references,                { desc = '[G]oto [R]eferences'   })

    end
}
