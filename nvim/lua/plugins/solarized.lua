-- Lua port of Solarized8 colour scheme
return {
    'ishan9299/nvim-solarized-lua',
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.background = 'light'
        vim.cmd [[ colorscheme solarized ]]
    end
}
