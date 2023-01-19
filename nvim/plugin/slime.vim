" Settings for the vim-slime plugin, which was a nightmare to port to Lua

" Use the Neovim terminal
let g:slime_target = "neovim"

" Use triple brackets as cell delimiters
let g:slime_cell_delimiter = "```"

" Function: get the appropriate language for the current filetype {{{1
function! GetLanguage()
    if &ft == "r" || &ft == "rmd"
        let language = "r"
    elseif &ft == "python"
        let language = "python"
    else
        let language = "bash"
    endif
    return language
endfunction

" Function: open a new REPL window {{{1
function! OpenTerminal() abort

    " Get starting window number
    let starting_window = bufwinnr(bufname('%'))

    " Get language
    let language = GetLanguage()

    " Open a terminal with appropriate language and move back to starting window
    if has('nvim')
        :execute ':vsplit term://' . language
        let t:term_id = b:terminal_job_id
        :execute starting_window 'wincmd w'
        :execute 'let b:slime_config = {"jobid": "' . t:term_id . '"}'
    else
        :execute ':vertical terminal ++close ++norestore ' . language
        :execute starting_window 'wincmd w'
        :SlimeConfig
    endif
endfunction

" Function: exit REPL windows {{{1
function! CloseTerminal() abort

    " Get language of current filetype
    let language = GetLanguage()

    " Close terminal using the appropriate command
    if language == "r"
        :SlimeSend1 quit(save = "no")
    elseif language == "python"
        :SlimeSend1 exit()
    else
        :SlimeSend1 exit
    endif
endfunction

" Function: print the head of a pandas/R dataframe {{{1
function! PrintHead() abort

    " Get language of current filetype
    let language = GetLanguage()

    " Get the word under the cursor
    let current_word = expand("<cword>")

    " Send appropriate command to REPL
    if language == "r"
        :SlimeSend0 "head(" . current_word . ")\n"
    elseif language == "python"
        :SlimeSend0 current_word . ".head()\n"
    else
        :echo "Error: requires Python or R"
    endif
endfunction

" Function: find function blocks {{{1
function! FindFunction() abort

    " Get language of current filetype
    let language = GetLanguage()

    " Find appropriate function block depending on language
    if language == "r"
        ?^[a-zA-Z_\.]*[[:space:]]<-[[:space:]]function(
        execute "normal! V"
        /^}
    elseif language == "python"
        ?^def[[:space:]][a-zA-Z0-9_()]*:
        execute "normal! V"
        /^[^# ]
        ?^\s\+\S
    endif
endfunction

" }}}1

" Mappings
nmap <localleader>l <plug>SlimeLineSend
nmap <localleader>p <plug>SlimeParagraphSend
xmap <localleader>s <plug>SlimeRegionSend
nmap <localleader>c <plug>SlimeSendCell
nmap <localleader>w viw<plug>SlimeRegionSend
nmap <localleader>a ggVG<plug>SlimeRegionSend
nmap <localleader>t :call OpenTerminal()<CR>
nmap <localleader>q :call CloseTerminal()<CR>
nmap <localleader>h :call PrintHead()<CR>
nmap <localleader>C :SlimeSend0 "\x03"<CR>
nmap <localleader>f :call FindFunction()<CR><plug>SlimeRegionSend<CR>

" vim: foldmethod=marker
