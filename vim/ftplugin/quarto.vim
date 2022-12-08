" Set commenstring
" autocmd FileType quarto set commentstring=#\ %s

" Use expression folding
" autocmd FileType quarto set foldmethod=expr

" Set the vim-slime delimiter for Quarto chunks
let g:slime_cell_delimiter = "```"

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
