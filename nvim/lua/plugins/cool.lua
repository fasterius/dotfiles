-- Disable search highlight after search is finished
return {
    'romainl/vim-cool',
    config = function()
        -- Show total number of search matches
        vim.g.cool_total_matches = true
    end
}
