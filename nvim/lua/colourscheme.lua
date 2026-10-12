-- Get the current host's colour scheme from `scripts/dotfiles-colourscheme.sh`,
-- which writes an environment variable and can be used to get the colour scheme
-- based on the current host. Falls back to Solarized if nothing is found.

-- Get colour scheme for environment variable
local colourscheme = vim.env.DOTFILES_COLOURSCHEME

-- Get colour scheme from script if environment variable is empty
if colourscheme == nil or colourscheme == "" then
    local script = vim.fn.expand("~/.dotfiles/scripts/dotfiles-colourscheme.sh")
    if vim.fn.executable(script) == 1 then
        local result = vim.system({ script }, { text = true }):wait()
        colourscheme = vim.trim(result.stdout or "")
    end
end

-- Fallback to Solarized if no colour scheme specification can be found
if colourscheme == nil or colourscheme == "" then
    colourscheme = "solarized"
end

return colourscheme
