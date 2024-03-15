-- Set leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Clear search highlights
vim.keymap.set('n', '<CR>', ':noh<CR>')

-- Store relative line number movement larger than 1 in the jumplist
-- Move by visual lines instead of physical lines
vim.keymap.set('n', 'j', [[v:count ? (v:count >= 1 ? "m'" . v:count : '') . 'j' : 'gj']], { expr = true })
vim.keymap.set('n', 'k', [[v:count ? (v:count >= 1 ? "m'" . v:count : '') . 'k' : 'gk']], { expr = true })
vim.keymap.set('n', '0', 'g0')
vim.keymap.set('n', '$', 'g$')

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

-- Neovim development
vim.keymap.set('n', '<localleader>x', ':source %<CR>')
