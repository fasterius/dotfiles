" Function for rendering RMarkdown/Sweave documents
function! RenderRMarkdown()
    :w!
    :SlimeSend0 "rmarkdown::render('" . expand("%:p") . "')\n"
    :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".html')\n"
endfunction
nmap <silent> <LocalLeader>k :call RenderRMarkdown()<CR>
