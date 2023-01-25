-- NeoVim configuration
-- Author: Erik Fasterius <erik dot fasterius at outlook dot com>
-- URL:    https://github.com/fasterius/dotfiles

-- Load plugins {{{1

-- Packer configuration {{{2

-- Function for bootstrapping
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- }}}2

require('packer').startup(function(use)

    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Autocompletion and snippets {{{2
    use { 'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',         -- Buffer source for nvim-cmp
            'hrsh7th/cmp-nvim-lsp',       -- Builtin LSP source for nvim-cmp
            'hrsh7th/cmp-path',           -- System paths source for nvim-cmp
            'saadparwaiz1/cmp_luasnip',   -- Snippet source for nvim-cmp
            'L3MON4D3/LuaSnip',           -- Snippet engine in Lua
            'onsails/lspkind.nvim',       -- Shows devicons in completion entry types
            'nvim-tree/nvim-web-devicons' -- Icons for use with patched fonts
        },
    }

    -- LSP {{{2
    use { 'neovim/nvim-lspconfig',
        requires = {
            -- Additional lua configuration; good for Lua development/nvim configs
            'folke/neodev.nvim',
        }
    }

    -- Telescope {{{2
    use { 'nvim-telescope/telescope.nvim',
        branch   = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- Fuzzy Finder algorithm which requires local dependencies to be built
    -- (only load if `make` is available)
    use { 'nvim-telescope/telescope-fzf-native.nvim',
        run  = 'make',
        cond = vim.fn.executable 'make' == 1
    }
    -- Treesitter {{{2
    use { 'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end
    }

    -- Additional text objects via Treesitter
    use { 'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }
    -- }}}2

    -- Appearance
    use 'romainl/vim-cool'             -- Disable search highlight after search is finished
    use 'wellle/context.vim'           -- Display the context of the currently visible buffer content, e.g. function definitions
    use 'junegunn/goyo.vim'            -- Distraction-free writing
    use 'nvim-lualine/lualine.nvim'    -- Fancier statusline
    use 'lcheylus/overlength.nvim'     -- Highlight text with width > textwidth
    use 'ishan9299/nvim-solarized-lua' -- Lua port of Solarized8 colour scheme

    -- File exploration
    use 'scrooloose/nerdtree' -- File tree browser

    -- Integrations
    use 'whiteinge/diffconflicts'                                        -- Working with Git merge conflicts
    use 'airblade/vim-gitgutter'                                         -- Show Git-changed code in the signcolumn
    use { 'quarto-dev/quarto-nvim', requires = { 'jmbuhr/otter.nvim' } } -- Working with Quarto files

    use 'alexghergh/nvim-tmux-navigation' -- Movement between NeoVim and Tmux

    -- Formatting
    use 'jiangmiao/auto-pairs'            -- Automatically insert bracket (etc.) pairs
    use 'numToStr/Comment.nvim'           -- Commenting code with Treesitter-support
    use 'tpope/vim-repeat'                -- Allow additional motions to be repeated
    use 'svermeulen/vim-subversive'       -- Add operators for substitutions
    use 'tpope/vim-surround'              -- Surround with brackets, parentheses, quotes, etc.
    use 'junegunn/vim-easy-align'         -- Alignment around user-based input

    -- REPL and terminal
    use 'jpalardy/vim-slime' -- An all-purpose REPL for sending code to a terminal

    -- Text objects
    use 'wellle/targets.vim'                                      -- Various text objects
    use 'kana/vim-textobj-user'                                   -- Text object framework
    use { 'kana/vim-textobj-entire', after = 'vim-textobj-user' } -- Entire buffer
    use { 'kana/vim-textobj-indent', after = 'vim-textobj-user' } -- Indentation
    use { 'kana/vim-textobj-line',   after = 'vim-textobj-user' } -- Lines

    -- Packer bootstrapping {{{2
    if packer_bootstrap then
        require('packer').sync()
    end
    -- }}}2

end)

-- Appearance {{{1

-- Add relative line numbers and absolute for the current line
vim.o.relativenumber = true
vim.o.number = true

-- Add background highlight to current line
vim.o.cursorline = true

-- Non-blinking block cursor
vim.o.guicursor = ''

-- Folding using Treesitter
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Enable 24-bit True Colour
vim.o.termguicolors = true

-- Use the Solarized light colour scheme
vim.o.background = 'light'
vim.cmd [[silent! colorscheme solarized]]

-- Don't show mode (it's in the statusline)
vim.o.showmode = false

-- Visually indent wrapped lines
vim.o.breakindent = true

-- Disable line numbers in terminals
vim.api.nvim_create_autocmd({'TermOpen'}, {
    pattern = {'*'},
    command = ':setlocal nonumber norelativenumber nocursorline'
})

-- Store Solarized colours for use in downstream plugin configuration
local colors = {
    base3   =  '#002b36',
    base2   =  '#073642',
    base1   =  '#586e75',
    base0   =  '#657b83',
    base00  =  '#839496',
    base01  =  '#93a1a1',
    base02  =  '#eee8d5',
    base03  =  '#fdf6e3',
    yellow  =  '#b58900',
    orange  =  '#cb4b16',
    red     =  '#dc322f',
    magenta =  '#d33682',
    violet  =  '#6c71c4',
    blue    =  '#268bd2',
    cyan    =  '#2aa198',
    green   =  '#859900',
}

-- Keymaps {{{1

-- Set leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Move by visual lines instead of physical lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

--  Keep selection after indenting in visual mode
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Center cursor in screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Movement in splits
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Movement in terminals
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('t', '<Esc>', '<C-\\><C-N>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d',        vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d',        vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Function to re-source the Neovim config with a workaround for preserving
-- marker-based folding for files inside the dotfiles repository while using
-- treesitter-based folding everywhere else
function SourceConfig()
    if vim.fn.match(vim.fn.expand('%:p'), 'dotfiles') > -1 then
        vim.cmd('source $MYVIMRC | setlocal foldmethod=marker')
    else
        vim.cmd('source $MYVIMRC')
    end
end
vim.keymap.set('n', '<leader>v', ':lua SourceConfig() <CR>')

-- Open Neovim config for editing
vim.keymap.set('n', '<leader><S-v>', ':sp <CR> :e $MYVIMRC <CR>')

-- Options {{{1

-- Wrap lines at 80 characters (formatoptions = defaults + t)
vim.o.textwidth = 80
vim.o.formatoptions = 'jcroqlt'

-- Use the system clipboard when not specifying a register
vim.o.clipboard = 'unnamed'

-- Create splits below and to the right
vim.o.splitbelow = true
vim.o.splitright = true

-- Tab settings
vim.o.expandtab = true -- Expand tabs to spaces
vim.o.tabstop = 4      -- Tabs are 4 spaces wide
vim.o.shiftwidth = 4   -- Use 4 spaces when indenting

-- Use case-insensitive searches, except when using capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Backup, swap and undo settings
vim.o.backup = true                      -- Keep backup files
vim.o.backupdir = '~/.tmp,/var/tmp,/tmp' -- Store backups in these directories
vim.o.directory = '~/.tmp,/var/tmp,/tmp' -- Store swapfiles in these directories
vim.o.undofile = true                    -- Keep undofiles
vim.o.undodir = '~/.tmp,/var/tmp,/tmp'   -- Store undofiles in these directories

-- Show completion popup even with only one match and do not select a match automatically
vim.o.completeopt = 'menuone,noselect'

-- Go to INSERT mode when moving to a terminal pane
vim.api.nvim_create_autocmd({'TermOpen', 'BufEnter', 'BufWinEnter'}, {
    pattern = {'term://*'},
    command = ':startinsert'
})

-- Go to NORMAL mode when moving from a terminal pane
vim.api.nvim_create_autocmd({'BufLeave', 'BufWinLeave'}, {
    pattern = {'term://*'},
    command = ':stopinsert'
})

-- Bypass [Process exited 0] prompt after closing a terminal
vim.api.nvim_create_autocmd({'TermClose'}, {
    pattern = {'*'},
    command = ':execute "bdelete! " . expand("<abuf>")'
})

-- Plugins {{{1

-- Comment {{{2

require('Comment').setup()

-- Completion {{{2

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
    -- Completion sources
    sources = {
        { name = 'buffer' },   -- Buffer
        { name = 'nvim_lsp' }, -- Neovim's built-in LSP
        { name = 'luasnip' },  -- LuaSnips
        { name = 'otter' }     -- For Quarto documents
    },
    -- Borders around completion popups
    window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    -- Show devicons in completion menu
    formatting = {
        format = function(entry, vim_item)
            if vim.tbl_contains({ 'path' }, entry.source.name) then
                local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
                if icon then
                    vim_item.kind = icon
                    vim_item.kind_hl_group = hl_group
                    return vim_item
                end
            end
            return require('lspkind').cmp_format({ with_text = true })(entry, vim_item)
        end
    },
    -- Snippets from LuaSnip
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    -- Keymaps
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>']  = cmp.mapping.confirm { select = false, },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }
}

-- Cool {{{2

-- Show total number of search matches
vim.g.cool_total_matches = true

-- EasyAlign {{{2

-- Use easyalign in normal and visual modes
vim.keymap.set('n', 'ga', '<plug>(EasyAlign)')
vim.keymap.set('x', 'ga', '<plug>(EasyAlign)')

-- Goyo {{{2

-- Set Goyo width to 81 to correctly wrap lines at 80 characters
vim.g.goyo_width = 81

-- LSP {{{2

-- Function that runs when an LSP connects to a buffer
local on_attach = function(_, bufnr)

    -- Generic function for implementing keymaps
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- LSP keymaps
    local lsp = vim.lsp.buf
    nmap('gd',         lsp.definition,      '[G]oto [D]efinition')
    nmap('gD',         lsp.declaration,     '[G]oto [D]eclaration')
    nmap('gI',         lsp.implementation,  '[G]oto [I]mplementation')
    nmap('K',          lsp.hover,           '[H]over Documentation')
    nmap('<leader>rn', lsp.rename,          '[R]e[n]ame')
    nmap('<leader>ca', lsp.code_action,     '[C]ode [A]ction')
    nmap('<leader>D',  lsp.type_definition, 'Type [D]efinition')

    -- Telescope keymaps
    local telescope = require('telescope.builtin')
    nmap('gr',         telescope.lsp_references,                '[G]oto [R]eferences')
    nmap('<leader>ds', telescope.lsp_document_symbols,          '[D]ocument [S]ymbols')
    nmap('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
end

-- Broadcast additional nvim-cmp completeion capabilities to language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Language server setups {{{3

require('lspconfig')['r_language_server'].setup {
    on_attach = on_attach
}
require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    python = {
        analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true
        }
    }
}

require('lspconfig')['bashls'].setup {
    on_attach = on_attach
}

require('lspconfig')['marksman'].setup {
    on_attach = on_attach
}

require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime         = { version = 'LuaJIT' },
            diagnostics     = { globals = {'vim'} },
            telemetry       = { enable  = false },
            workspace       = {
                library         = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            }
        }
    }
}

require('lspconfig')['vimls'].setup {
    on_attach = on_attach
}

-- Neodev setup for LSPs inside Neovim Lua config-related files
require('neodev').setup()

-- }}}3

-- Lualine {{{2

-- Customise Solarized colour theme
local solarized = require('lualine.themes.solarized')
solarized.normal.a.bg   = colors.base2  -- Black NORMAL mode
solarized.insert.a.bg   = colors.blue   -- Blue INSERT mode
solarized.visual.a.bg   = colors.cyan   -- Cyan VISUAL mode
solarized.replace.a.bg  = colors.orange -- Orange REPLACE mode
solarized.inactive.c.bg = colors.base02 -- Inactive statusline
-- solarized.inactive.c.fg = colors.base02 -- Inactive statusline

-- Lualine setup
require('lualine').setup {
    options = {
        icons_enabled        = true,
        theme                = 'solarized',
        component_separators = '|',
        section_separators   = ''
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', file_status = false } , 'diff', },
        lualine_x = { { 'diagnostics', sources = {'nvim_lsp'}}, 'filetype' } ,
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', file_status = false } },
        lualine_x = { 'filetype' },
        lualine_y = {},
        lualine_z = {}
    }
}

-- NERDTree {{{2

-- Quite NERDTree after opening a file
vim.g.NERDTreeQuitOnOpen = true
vim.keymap.set('n', '<leader>t', ':NERDTreeToggle <CR>')

-- Overlength {{{2

require('overlength').setup({

    -- Solarized colour: same as cursorline
    bg = '#EEE8D5',

    -- Highlight only the column itself
    highlight_to_eol = false
})

-- Quarto {{{2

require('quarto').setup {
    lspFeatures = {
        enabled     = true,
        languages   = { 'r', 'python' },
        diagnostics = { enabled = true, triggers = { "BufWrite" } },
        cmpSource   = { enabled = true }
    }
}

-- Subversive {{{2

-- Substitute motion with register content
vim.keymap.set('n', 's', '<plug>(SubversiveSubstitute)')

-- Substitite word under cursor within motion with user input
vim.keymap.set('n', '<leader>s', '<plug>(SubversiveSubstituteRange)')
vim.keymap.set('x', '<leader>s', '<plug>(SubversiveSubstituteRange)')

-- Substitute word under curser within motion with user input
vim.keymap.set('n', '<leader>ss', '<plug>(SubversiveSubstituteWordRange)')

-- Do not move cursor after substituting
vim.g.subversivePreserveCursorPosition = 1

-- Telescope {{{2

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
vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = colors.blue })

-- Enable telescope fzf native (if installed)
pcall(require('telescope').load_extension, 'fzf')

-- Keymaps
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>fg', telescope.git_files,                 { desc = '[F]ind files inside [G]it repository' })
vim.keymap.set('n', '<leader>ff', telescope.find_files,                { desc = '[F]ind [F]iles in the current working directory' })
vim.keymap.set('n', '<leader>fb', telescope.buffers,                   { desc = '[F]ind existing [B]uffers' })
vim.keymap.set('n', '<leader>sh', telescope.help_tags,                 { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sd', telescope.diagnostics,               { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>/',  telescope.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sg', function()
    telescope.live_grep{ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }
end, { desc = "[S]earch inside [G]it repository "})
vim.keymap.set('n', '<leader>sw', function()
    telescope.grep_string{ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }
end, { desc = '[S]earch current [W]ord inside Git repository' })

-- Tmux-navigation {{{2

require('nvim-tmux-navigation').setup {
    keybindings = {
        left        = "<C-h>",
        down        = "<C-j>",
        up          = "<C-k>",
        right       = "<C-l>"
    },
    disable_when_zoomed = true, -- Disable movement when zoomed in to a pane
}

-- Treesitter {{{2
require('nvim-treesitter.configs').setup({

    -- Languages to always be installed
    ensure_installed = { 'lua', 'python', 'r', 'bash', 'markdown', 'help', 'vim' },

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

-- }}}2

-- Modeline {{{1
-- vim: foldmethod=marker
