-- An all-purpose REPL for sending code to a terminal
return {
    'jpalardy/vim-slime',
    keys = {
        { '<localleader>r' },
        { '<localleader>C' },
        { '<localleader>P' }
    },
    config = function()

        -- Use the Neovim terminal
        vim.api.nvim_set_var('slime_target', 'neovim')

        -- Use triple brackets as cell delimiters
        vim.api.nvim_set_var('slime_cell_delimiter', '```')

        -- General mappings
        vim.keymap.set('n', '<localleader>s', '<plug>SlimeMotionSend')
        vim.keymap.set('n', '<localleader>l', '<plug>SlimeLineSend')
        vim.keymap.set('n', '<localleader>p', '<plug>SlimeParagraphSend')
        vim.keymap.set('x', '<localleader>v', '<plug>SlimeRegionSend')
        vim.keymap.set('n', '<localleader>c', '<plug>SlimeSendCell')
        vim.keymap.set('n', '<localleader>C', ':SlimeSend0 "\\x03"<CR>')

        -- Get the appopriate language from the YAML header in Quarto files
        vim.cmd [[
            function! GetQuartoLanguage() abort
                " Parse the YAML header and find the chosen language
                let current_position = getpos('.')
                normal! gg
                let line = search('^knitr:\|^jupyter:', 'W')
                call setpos('.', current_position)
                " Check for Knitr
                if (split(getline(line))[0] == 'knitr:')
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

        -- Open a REPL with appropriate language and move back to starting window
        vim.cmd [[
            function! OpenTerminal(split) abort
                let starting_window = bufwinnr(bufname('%'))
                let language = GetLanguage()
                if executable(language) == 0
                    echo "Error: language `" . language . "` not installed"
                    return 1
                endif
                :execute ':' . a:split . ' term://' . language
                let t:term_id = b:terminal_job_id
                let terminal_window = bufwinnr(bufname('%'))
                :execute starting_window .. 'wincmd w'
                :execute 'let b:slime_config = {"jobid": "' . t:term_id . '"}'
            endfunction
        ]]

         -- Exit a REPL window
        vim.cmd [[
            function! CloseTerminal() abort
                let language = GetLanguage()
                " Close terminal using the appropriate command
                if language == "r"
                    :SlimeSend1 quit(save = "no")
                elseif language == "python3"
                    :SlimeSend1 exit()
                else
                    :SlimeSend1 exit
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
        vim.keymap.set('n', '<localleader>r', ':call OpenTerminal("vsplit")<CR>')
        vim.keymap.set('n', '<localleader>R', ':call OpenTerminal("split")<CR>')
        vim.keymap.set('n', '<localleader>q', ':call CloseTerminal()<CR>')
        vim.keymap.set('n', '<localleader>h', ':call PrintHead()<CR>')
        vim.keymap.set('n', '<localleader>n', ':call PrintNames()<CR>')
        vim.keymap.set('n', '<localleader>k', ':call RenderDocument()<CR>')
        vim.keymap.set('n', '<localleader>P', ':call QuartoPreview()<CR>')

        -- Insert Quarto code chunks based on document language
        vim.cmd [[
            function! InsertQuartoCodeChunk() abort
                let language = GetLanguage()
                :call feedkeys("i```{" . language . "}\n\n```\<UP>")
            endfunction
        ]]
        vim.keymap.set('n', '<localleader>C', ':call InsertQuartoCodeChunk()<CR>')
    end
}
