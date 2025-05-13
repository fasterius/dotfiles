-- An all-purpose REPL for sending code to a terminal
return {
    "jpalardy/vim-slime",
    keys = {
        { "<localleader>C" },
        { "<localleader>P" },
        { "<localleader>c" },
        { "<localleader>l" },
        { "<localleader>r" },
        { "<localleader>s" },
        { "<localleader>v" },
        { "<localleader>h" },
        { "<localleader>n" },
    },
    config = function()
        -- Use Tmux as target
        vim.g.slime_target = "tmux"

        -- Pre-fill configuration with default socket and pane 1
        vim.g.slime_default_config = {
            socket_name = "default",
            target_pane = "1",
        }

        -- Do not use default mappings
        vim.api.nvim_set_var("slime_no_mappings", 1)

        -- Use triple brackets as cell delimiters
        vim.g.slime_cell_delimiter = "```"

        -- General mappings
        vim.keymap.set("n", "<localleader>s", "<plug>SlimeMotionSend")
        vim.keymap.set("n", "<localleader>l", "<plug>SlimeLineSend")
        vim.keymap.set("x", "<localleader>v", "<plug>SlimeRegionSend")
        vim.keymap.set("n", "<localleader>c", "<plug>SlimeSendCell")
        vim.keymap.set("n", "<localleader>C", ':SlimeSend0 "\\x03"<CR>')

        local function getQuartoLanguage()
            -- Store the current cursor position for later repositioning
            local current_position = vim.api.nvim_win_get_cursor(0)

            -- Parse the YAML header and get the line with language information
            vim.api.nvim_command("normal! gg")
            local line_number = vim.fn.search("^knitr:\\|^jupyter:\\|^engine:", "W")

            -- Reposition cursor to original position
            vim.api.nvim_win_set_cursor(0, current_position)

            -- Handle non-existant matches
            if line_number == 0 then
                return nil
            end

            -- Parse language information line and get document language
            local line = vim.split(vim.fn.getline(line_number), "%s+")
            if line[1] == "engine:" then
                if line[2] == "knitr" then
                    return "r"
                else
                    return "python"
                end
            elseif line[1] == "knitr:" then
                return "r"
            elseif line[1] == "jupyter:" then
                local kernel = string.match(vim.fn.getline(line_number), "^jupyter: (.*)")
                if kernel == "python" or kernel == "r" then
                    return kernel
                end
            else
                return nil
            end
        end

        local function getLanguage()
            -- Access the filetype of the current buffer
            local filetype = vim.bo.filetype

            -- Check the filetype and return corresponding language
            if filetype == "r" or filetype == "rmd" then
                return "r"
            elseif filetype == "python" then
                return "python"
            elseif filetype == "quarto" then
                return getQuartoLanguage()
            else
                return nil
            end
        end

        local function printHead()
            -- Get the current word under the cursor
            local current_word = vim.fn.expand("<cword>")
            -- Print the language-dependent head of the current word
            local language = getLanguage()
            if language == "r" then
                vim.cmd('SlimeSend0 "head(' .. current_word .. ')\\n"')
            elseif language == "python" then
                vim.cmd('SlimeSend0 "' .. current_word .. '.head()\\n"')
            else
                print("Error: requires Python or R")
            end
        end

        local function printNames()
            -- Get the current word under the cursor
            local current_word = vim.fn.expand("<cword>")
            -- Print the language-dependent column names of the current word
            local language = getLanguage()
            if language == "r" then
                vim.cmd('SlimeSend0 "names(' .. current_word .. ')\\n"')
            elseif language == "python" then
                vim.cmd('SlimeSend0 "list(' .. current_word .. ')\\n"')
            else
                print("Error: requires Python or R")
            end
        end

        -- Function mappings
        vim.keymap.set("n", "<localleader>h", printHead)
        vim.keymap.set("n", "<localleader>n", printNames)
    end,
}
