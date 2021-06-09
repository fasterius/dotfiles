" Function for rendering Sweave documents
function! RenderSweave()
    :w!
    :SlimeSend0 "knitr::knit2pdf('" . expand("%:p") . "')\n"
    :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".pdf')\n"
endfunction
nmap <silent> <LocalLeader>k :call RenderSweave()<CR>
