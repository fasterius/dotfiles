-- Highlight colour codes with the actual colours
vim.pack.add({ 'https://github.com/NvChad/nvim-colorizer.lua' })

-- cmd = {
-- "ColorizerAttachToBuffer",
-- "ColorizerToggle",
-- },

require("colorizer").setup({
    -- Don't colour e.g. `red` or `blue`
    user_default_options = {
	names = false,
    },
})
