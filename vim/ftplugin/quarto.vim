" Preview Quarto document in a tab
function! QuartoPreview()
    :w!
    :terminal ++curwin quarto preview %:p --to html
    :bprevious
endfunction
nmap <silent> <LocalLeader>P :call QuartoPreview()<CR>

" Function for rendering Quarto documents
function! RenderQuarto()
    :w!
    :SlimeSend0 "system2('quarto', 'render " . expand("%:p") . " --to html')\n"
    :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".html')\n"
endfunction
nmap <silent> <LocalLeader>k :call RenderQuarto()<CR>

" Quarto-specific function to find language from the YAML header
" This is used in conjunction with the generalised REPL functions in the main
" VIMRC file, where another function with the same name and slightly different
" functionality is used.
function! GetLanguage() abort

    " Parse the YAML header and find the chosen kernel
    let current_position = getpos('.')
    normal! gg
    let line = search('^kernel: .*$', 'W')
    call setpos('.', current_position)

    " Check for existance of kernel specification
    try
        let kernel = matchlist(getline(line), 'kernel: \(.*\)')[1]
    catch
        echoerr "No kernel specification found; aborting"
    endtry

    " Get the language based on specified kernel
    echo 'Quarto [' . kernel . "] kernel found"
    if (kernel == "python3")
        let language = "python"
    elseif (kernel == "knitr")
        let language = "r"
    else
        let language = "r"
    endif
    return language
endfunction
