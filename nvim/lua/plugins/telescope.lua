-- Fuzzy finding with Telescope
return {
    'nvim-telescope/telescope.nvim',
    branch       = '0.1.x',
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

        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        -- Disable scrolling inside preview windows
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                        -- Make a single <Esc> exit Telescope
                        ["<esc>"] = require("telescope.actions").close
                    }
                }
            }
        }

        -- Change colour of search results
        -- TODO: don't hard-code
        vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#268bd2' })

        -- Enable telescope fzf native (if installed)
        pcall(require('telescope').load_extension, 'fzf')

        -- Keymaps
        local telescope = require('telescope.builtin')
        vim.keymap.set('n', '<leader>fg', telescope.git_files, { desc = '[F]ind files inside [G]it repository' })
        vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = '[F]ind [F]iles in the current working directory' })
        vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = '[F]ind existing [B]uffers' })
        vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>/',  telescope.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer]' })
        vim.keymap.set('n', '<leader>sg', function()
            telescope.live_grep { cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }
        end, { desc = "[S]earch inside [G]it repository " })
        vim.keymap.set('n', '<leader>sw', function()
            telescope.grep_string { cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }
        end, { desc = '[S]earch current [W]ord inside Git repository' })

    end
}
