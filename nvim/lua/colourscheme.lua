-- Get the current host's colour scheme from the `DOTFILES_COLOURSCHEME`
-- environment variable, exported by `bashrc` from `host.sh`.
-- Falls back to Solarized if it isn't set.

local colourscheme = vim.env.DOTFILES_COLOURSCHEME
if colourscheme == nil or colourscheme == "" then
    colourscheme = "solarized"
end

return colourscheme
