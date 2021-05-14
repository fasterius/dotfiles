" Use expression folding
autocmd FileType rmarkdown set foldmethod=expr

" Function for rendering RMarkdown/Sweave documents
function! RenderRMarkdown()
    :w!
    :SlimeSend0 "rmarkdown::render('" . expand("%:p") . "')\n"
    :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".html')\n"
endfunction

" Function for rendering RMarkdown presentations with Xaringan into HTML
function! RenderXaringan()
    :w!
    :SlimeSend0 "rmarkdown::render('" . expand("%:p") . "', 'xaringan::moon_reader')\n"
    :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".html')\n"
endfunction

" Function for rendering RMarkdown presentations with Xaringan into HTML and PDF
function! RenderXaringanPDF()
    :w!
    :SlimeSend0 "rmarkdown::render('" . expand("%:p") . "', 'xaringan::moon_reader')\n"
    :SlimeSend0 "webshot::webshot('" . expand("%:p:r") . ".html', '" . expand("%:p:r") . ".pdf')\n"
    :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".pdf')\n"
endfunction

" Render current RMarkdown/Sweave file
nmap <silent> <LocalLeader>k :call RenderRMarkdown()<CR>
nmap <silent> <LocalLeader>x :call RenderXaringan()<CR>
nmap <silent> <LocalLeader>X :call RenderXaringanPDF()<CR>
