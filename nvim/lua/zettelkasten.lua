-- Location of the Zettelkasten, shared by `plugin/zettelkasten.lua` and the
-- Markdown / Markdown-Oxide language server configs
local M = {}

-- Resolve symlinks since buffer names use the real path
M.dir =
    vim.fs.normalize(vim.fn.resolve(vim.fs.normalize("~/docs/zettelkasten")))

---Function to check whether a buffer is a note inside the Zettelkasten
---@param bufnr integer
---@return boolean
function M.contains(bufnr)
    local name = vim.api.nvim_buf_get_name(bufnr)
    name = vim.fs.normalize(vim.fn.resolve(name))
    return vim.startswith(name, M.dir .. "/")
end

---Make an unbreakable placeholder with the same displayed width as a concealed
---wiki link (`[[Target|alias]]` shows only `alias`), and record the link
---@param link string
---@param links table<string, string> Original link by placeholder
---@return string
local function make_placeholder(link, links)
    -- Placeholder characters, from the Unicode Private Use Area: one
    -- character that identifies the link, padded with a filler to the
    -- link's displayed width
    local PLACEHOLDER_BASE = 0xE000
    local PLACEHOLDER_FILL = 0xF8FF

    -- Remove opening/closing brackets
    local inner = link:sub(3, -3)

    -- Find width of the displayed text (alias if it exists, otherwise just
    -- the target)
    local width = vim.fn.strdisplaywidth(inner:match("|(.*)$") or inner)

    -- Create a link ID using the BASE placeholder and the number of the link;
    -- this ID is one character wide
    local id = vim.fn.nr2char(PLACEHOLDER_BASE + vim.tbl_count(links))

    -- Create the final placeholder that is `width` wide by concatenating
    -- the ID and a repeated FILL string `width - 1` wide.
    local fill = vim.fn.nr2char(PLACEHOLDER_FILL):rep(width - 1)
    links[id .. fill] = link
    return id .. fill
end

---Replace every wiki link in `lines` with a placeholder
---@param lines string[]
---@param links table<string, string> Filled with original link by placeholder
---@return string[]
local function hide_links(lines, links)
    local hidden = {}
    for i, line in ipairs(lines) do
        hidden[i] = line:gsub("%[%[[^%]]*%]%]", function(link)
            return make_placeholder(link, links)
        end)
    end
    return hidden
end

---Replace every placeholder in `lines` with its original link
---@param lines string[]
---@param links table<string, string> Original link by placeholder
---@return string[]
local function restore_links(lines, links)
    local restored = {}
    for i, line in ipairs(lines) do
        for placeholder, link in pairs(links) do
            -- Use function that returns `link` instead of the plain string in
            -- variable `link`, so that `%` characters are not treated specially
            line = line:gsub(vim.pesc(placeholder), function()
                return link
            end)
        end
        restored[i] = line
    end
    return restored
end

---`formatexpr` for Zettelkasten notes: format by displayed width, with each
---concealed wiki link (`[[Target|alias]]`) counting as only its alias. The
---lines are formatted by Neovim itself after swapping each link for a
---placeholder of the same displayed width.
---@return integer
function M.formatexpr()
    -- Use normal formatting when in insert or REPLACE mode
    if vim.fn.mode():find("[iR]") then
        return 1
    end

    -- Get line numbers of the lines to be formatted
    local first = vim.v.lnum
    local last = first + vim.v.count - 1

    -- Get the content of the lines to be formatted
    local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)

    local links = {}

    -- Store current formatexpr for later and clear it, so that the the
    -- command below doesn't call itself recursively
    local formatexpr = vim.bo.formatexpr
    vim.bo.formatexpr = ""

    -- Replace links with placeholders with the same width as their alias
    lines = hide_links(lines, links)
    vim.api.nvim_buf_set_lines(0, first - 1, last, false, lines)

    -- Format the lines
    vim.cmd(("keepjumps keeppatterns normal! %dGV%dGgq"):format(first, last))

    -- Restore formatexpr
    vim.bo.formatexpr = formatexpr

    -- Find the line that is now the end of the range
    local new_last = vim.fn.line("']")

    -- Restore the original links in the (now formatted) range
    lines = vim.api.nvim_buf_get_lines(0, first - 1, new_last, false)
    lines = restore_links(lines, links)
    vim.api.nvim_buf_set_lines(0, first - 1, new_last, false, lines)

    -- Restore cursor to the beginning of the last formatted line (mirroring
    -- what e.g. `gq` does)
    vim.api.nvim_win_set_cursor(0, { new_last, 0 })
    vim.cmd("normal! ^")

    return 0
end

return M
