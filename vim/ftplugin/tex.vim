" Compile current LaTeX to PDF and open
nmap <buffer> <localleader>k
    \ :w!<CR>
    \ :!pdflatex "%:p" <CR>
    \ :!open "%:p:r.pdf" <CR><CR>
