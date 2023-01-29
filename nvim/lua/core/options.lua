-- Non-blinking block cursor
vim.o.guicursor = ''

-- Add relative line numbers and absolute for the current line
vim.o.relativenumber = true
vim.o.number = true

-- Add background highlight to current line
vim.o.cursorline = true

-- Wrap lines at 80 characters (formatoptions = defaults + t)
vim.o.textwidth = 80
vim.o.formatoptions = 'jcroqlt'

-- Don't show mode (it's in the statusline)
vim.o.showmode = false

-- Enable 24-bit True Colour
vim.o.termguicolors = true

-- Visually indent wrapped lines
vim.o.breakindent = true

-- Use the system clipboard when not specifying a register
vim.o.clipboard = 'unnamed'

-- Use case-insensitive searches, except when using capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show completion popup even with only one match and do not select a match automatically
vim.o.completeopt = 'menuone,noselect'

-- Disable the default Neovim file tree browser `netwr` in favour of plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Split settings ]]
vim.o.splitbelow = true -- Create horizontal splits below
vim.o.splitright = true -- Create vertical splits to the right

-- [[ Tab settings ]]
vim.o.expandtab = true -- Expand tabs to spaces
vim.o.tabstop = 4      -- Tabs are 4 spaces wide
vim.o.shiftwidth = 4   -- Use 4 spaces when indenting

-- [[ Backup, swap and undo settings ]]
vim.o.backup = true                      -- Keep backup files
vim.o.backupdir = '~/.tmp,/var/tmp,/tmp' -- Store backups in these directories
vim.o.directory = '~/.tmp,/var/tmp,/tmp' -- Store swapfiles in these directories
vim.o.undofile = true                    -- Keep undofiles
vim.o.undodir = '~/.tmp,/var/tmp,/tmp'   -- Store undofiles in these directories

-- Folding using Treesitter
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
