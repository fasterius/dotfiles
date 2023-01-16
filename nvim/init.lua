-- NeoVim configuration
-- Author: Erik Fasterius <erik dot fasterius at outlook dot com>
-- URL:    https://github.com/fasterius/dotfiles

-- Load plugins {{{1

-- Packer auto-installation {{{2

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

-- }}}2

require('packer').startup(function(use)

    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Autocompletion and snippets {{{2
    use {
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', -- Builtin LSP source for nvim-cmp
            'L3MON4D3/LuaSnip',              -- Snippet engine in Lua
            'saadparwaiz1/cmp_luasnip'       -- Snippet source for nvim-cmp
        },
    }

    -- LSP {{{2
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status/progress updates for LSP while running
            'j-hui/fidget.nvim',

            -- Additional lua configuration, good for Lua development/nvim configs
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
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end
    }

    use { -- Additional text objects via Treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
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
    use 'whiteinge/diffconflicts'         -- Working with Git merge conflicts
    use 'airblade/vim-gitgutter'          -- Show Git-changed code in the signcolumn
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
    use 'wellle/targets.vim'      -- Several additional text objects
    use 'kana/vim-textobj-entire' -- Text object: entire buffer
    use 'kana/vim-textobj-indent' -- Text object: indentation
    use 'kana/vim-textobj-line'   -- Text object: line
    use 'kana/vim-textobj-user'   -- Framework for creating text objects

    -- Packer bootstrapping {{{2
    -- First-time installation of all plugins on bootstrapping
    if is_bootstrap then
        require('packer').sync()
    end
end)

-- }}}2

-- Appearance {{{1

-- Add relative line numbers and absolute for the current line
vim.o.relativenumber = true
vim.o.number = true

-- Add background highlight to current line
vim.o.cursorline = true

-- Non-blinking block cursor
vim.o.guicursor = ''

-- -- Folding using Treesitter
-- vim.o.foldenable = true
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Enable 24-bit True Colour
vim.o.termguicolors = true

-- Use the Solarized light colour scheme
vim.o.background = 'light'
vim.cmd [[colorscheme solarized]]

-- Don't show mode, (it's in the statusline)
vim.o.showmode = false

-- " Highlight the first character exceeding a linewidth of 80
-- " (needs to be after any colorscheme specification to work)
-- highlight ColorColumn guibg=#93a1a1 guifg=white
-- call matchadd('ColorColumn', '\%81v.', 100)

-- Visually indent wrapped lines
vim.o.breakindent = true

-- Disable line numbers in terminals
vim.api.nvim_create_autocmd({'TermOpen'}, {
    pattern = {'*'},
    command = ':setlocal nonumber norelativenumber'
})

-- " Highlight the first character exceeding a linewidth of 80
-- " (needs to be after any colorscheme specification to work)
-- highlight ColorColumn guibg=#93a1a1 guifg=white
-- call matchadd('ColorColumn', '\%81v.', 100)

-- General settings {{{1

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

-- Start terminals in insert and go to normal mode upon exiting
vim.api.nvim_create_autocmd({'TermOpen'}, {
    pattern = {'*'},
    command = ':startinsert'
})
vim.api.nvim_create_autocmd({'TermClose'}, {
    pattern = {'*'},
    command = "execute! 'bdelete! ' . expand('<abuf>'); :stopinsert"
})

-- vim.api.nvim_create_autocmd({'TermClose'
-- :autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')

-- General key maps {{{1

-- Set leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Re-source `init.lua`
vim.keymap.set('n', '<leader>v', ':source $MYVIMRC <CR>')

-- Open `init.lua` for editing
vim.keymap.set('n', '<leader><S-v>', ':sp <CR> :e $MYVIMRC <CR>')

-- Move around splits using Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- -- Movement to/from terminals
-- vim.keymap.set('t', '<C-h>' '<C-\><C-N><C-w>h')
-- vim.keymap.set('t', '<C-j>' '<C-\><C-N><C-w>j')
-- vim.keymap.set('t', '<C-k>' '<C-\><C-N><C-w>k')
-- vim.keymap.set('t', '<C-l>' '<C-\><C-N><C-w>l')

-- Move by visual lines instead of physical lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

--  Keep selection after indenting in visual mode
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- }}}1
-- Plugin settings {{{1

-- Comment {{{2

require('Comment').setup()

-- Completion {{{2

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
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
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- Cool {{{2

-- Show total number of search matches
vim.g.cool_total_matches = true

-- EasyAlign {{{2

vim.keymap.set('n', 'ga', '<plug>(EasyAlign)')
vim.keymap.set('x', 'ga', '<plug>(EasyAlign)')

-- Fidget {{{2

require('fidget').setup()

-- Goyo {{{2

-- Set Goyo width to 81 to correctly wrap lines at 80 characters
vim.g.goyo_width = 81

-- LSP {{{2

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},

    sumneko_lua = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = {'vim'} }
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Lualine {{{2

require('lualine').setup {
    options = {
        icons_enabled        = false,
        theme                = 'solarized',
        component_separators = '|',
        section_separators   = '',
    },
}

-- Mason {{{2

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

-- NERDTree {{{2

vim.g.NERDTreeQuitOnOpen = true
vim.keymap.set('n', '<leader>t', ':NERDTreeToggle <CR>')

-- Overlength {{{2

require('overlength').setup({

    -- Solarized colour: cursorline
    bg = '#EEE8D5',

    -- Highlight only the column itself
    highlight_to_eol = false
})

-- Slime TODO {{{2


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
                ['<C-u>'] = false,
                ['<C-d>'] = false,
},
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Tmux-navigation {{{2
require'nvim-tmux-navigation'.setup {
    -- Disable movement when zoomed in to a pane
    disable_when_zoomed = true,
    keybindings = {
        left        = "<C-h>",
        down        = "<C-j>",
        up          = "<C-k>",
        right       = "<C-l>",
        last_active = "<C-\\>",
        next        = "<C-Space>",
    }
}

-- Treesitter {{{2
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'lua', 'python', 'r', 'markdown', 'help', 'vim' },

    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
    enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
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
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- }}}2

-- Modeline {{{1

-- Set foldmethod to `marker` inside this file using the modeline
vim.o.modelines = 1
-- vim: foldmethod=marker
