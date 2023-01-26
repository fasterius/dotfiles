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

-- function SourceConfig()
--     if vim.fn.match(vim.fn.expand('%:p'), 'dotfiles') > -1 then
--         vim.cmd('source $MYVIMRC | setlocal foldmethod=marker')
--     else
--         vim.cmd('source $MYVIMRC')
--     end
-- end
-- vim.keymap.set('n', '<leader>v', ':lua SourceConfig() <CR>')

vim.keymap.set('n', '<leader>v', ':source $MYVIMRC <CR>')
