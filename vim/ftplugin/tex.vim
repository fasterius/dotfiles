" Compile current LaTeX to PDF and open
nmap <buffer> <localleader>L
    \ :w!<CR>
    \ :!pdflatex "%:p" <CR>
    \ :!open "%:p:r.pdf" <CR><CR>
