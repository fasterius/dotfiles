-- An all-purpose REPL for sending code to a terminal
return {
    'jpalardy/vim-slime',
    keys = {
        { '<localleader>C' },
        { '<localleader>P' },
        { '<localleader>c' },
        { '<localleader>l' },
        { '<localleader>r' },
        { '<localleader>s' },
        { '<localleader>v' },
    },
    config = function()

        -- Use Tmux as target
        vim.g.slime_target = "tmux"

        -- Pre-fill configuration with default socket and pane 1
        vim.g.slime_default_config = {
            socket_name = "default",
            target_pane = "1"
        }

        -- Do not use default mappings
        vim.api.nvim_set_var('slime_no_mappings', 1)

        -- Use triple brackets as cell delimiters
        vim.g.slime_cell_delimiter = "```"

        -- General mappings
        vim.keymap.set('n', '<localleader>s', '<plug>SlimeMotionSend')
        vim.keymap.set('n', '<localleader>l', '<plug>SlimeLineSend')
        vim.keymap.set('x', '<localleader>v', '<plug>SlimeRegionSend')
        vim.keymap.set('n', '<localleader>c', '<plug>SlimeSendCell')
        vim.keymap.set('n', '<localleader>C', ':SlimeSend0 "\\x03"<CR>')

        -- Get the appopriate language from the YAML header in Quarto files
        vim.cmd [[
            function! GetQuartoLanguage() abort
                " Parse the YAML header and find the chosen language
                let current_position = getpos('.')
                normal! gg
                let line = search('^knitr:\|^jupyter:\|^engine:', 'W')
                call setpos('.', current_position)
                let line = split(getline(line))
                " Check for engine
                if (line[0] == 'engine:')
                    if (line[1] == 'knitr')
                        return 'r'
                    else
                        return 'python3'
                    endif
                " Check for Knitr
                elseif (line[0] == 'knitr:')
                    return 'r'
                else
                    " Check for Jupyter kernel
                    let kernel = matchlist(getline(line), '^jupyter: \(.*\)')[1]
                    if (kernel == 'python3')
                        return 'python3'
                    elseif (kernel == 'r')
                        return 'r'
                    else
                        return 'r'
                    endif
                endif
            endfunction
        ]]

        -- Get the appropriate language for the current filetype
        vim.cmd [[
            function! GetLanguage() abort
                if &ft == "r" || &ft == "rmd"
                    return "r"
                elseif &ft == "python"
                    return "python3"
                elseif &ft == "quarto"
                    return GetQuartoLanguage()
                else
                    return "bash"
                endif
            endfunction
        ]]

        -- Print the head of a pandas/R dataframe
        vim.cmd [[
            function! PrintHead() abort
                let language = GetLanguage()
                let current_word = expand("<cword>")
                if language == "r"
                    :SlimeSend0 "head(" . current_word . ")\n"
                elseif language == "python"
                    :SlimeSend0 current_word . ".head()\n"
                else
                    :echo "Error: requires Python or R"
                endif
            endfunction
        ]]

        -- Print column names of a pandas/R dataframe
        vim.cmd [[
            function! PrintNames() abort
                let language = GetLanguage()
                let current_word = expand("<cword>")
                if language == "r"
                    :SlimeSend0 "names(" . current_word . ")\n"
                elseif language == "python"
                    :SlimeSend0 "list(" . current_word . ")\n"
                else
                    :echo "Error: requires Python or R"
                endif
            endfunction
        ]]

        -- Render R Markdown and Quarto documents
        vim.cmd [[
            function! RenderDocument() abort
                :w!
                if &ft == "rmd"
                    :SlimeSend0 "rmarkdown::render('" . expand("%:p") . "')\n"
                    :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".html')\n"
                elseif &ft == "quarto" || &ft == "markdown"
                    let language = GetLanguage()
                    if language == "r"
                        :SlimeSend0 "system2('quarto', 'render " . expand("%:p") . "')\n"
                        :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".html')\n"
                    elseif language == "python3"
                        :SlimeSend0 "import os\n"
                        :SlimeSend0 "os.system('quarto render " . expand("%:p") . "')\n"
                        :SlimeSend0 "os.system('open " . expand("%:p:r") . ".html')\n"
                    endif
                else
                    :echo "Error: can only render R Markdown or Quarto documents"
                endif
            endfunction
        ]]

        -- Quarto preview in hidden buffer
        vim.cmd [[
            function! QuartoPreview()
                :w!
                :terminal ++curwin quarto preview %:p --to html
                :bprevious
            endfunction
        ]]

        -- Function mappings
        vim.keymap.set('n', '<localleader>h', ':call PrintHead()<CR>')
        vim.keymap.set('n', '<localleader>n', ':call PrintNames()<CR>')
        vim.keymap.set('n', '<localleader>k', ':call RenderDocument()<CR>')
        vim.keymap.set('n', '<localleader>P', ':call QuartoPreview()<CR>')

    end
}
