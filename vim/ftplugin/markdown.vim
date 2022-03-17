" Render and display markdown in browser
if executable("grip")
    nnoremap <localleader>m : !grip -b % <CR>
endif
