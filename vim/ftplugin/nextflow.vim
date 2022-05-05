autocmd BufEnter *.nf :syntax sync fromstart

" Helper function for getting the next non-blank line for folding
function! NextNonBlankLine(lnum)
    let numlines = line('$')  " Get total lines in file
    let current = a:lnum + 1  " Set current line to next line

    " Get the linenumber of next non-whitespace line
    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif
        let current += 1
    endwhile

    " Return -2 upon reaching the of the file
    return -2
endfunction

" Helper function for getting indent folding
function! IndentLevel(lnum)
    let indentlevel = indent(a:lnum) / &shiftwidth
    return min([indentlevel, 1])  " Do not nest folds
endfunction

" Main folding function
function! NextflowFold(lnum)

    " Fold import statements
    if getline(a:lnum) =~? '\v^import'
        return 1
    endif

    " Fold ending curly-brackets with previous lines
    if getline(a:lnum) =~? '\v^}$'
        return '-1'
    endif

    " Get indentation level of current line and next non-blank line
    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    " Fold blank lines with later lines
    if getline(a:lnum) =~? '\v^\s*$'
        if getline(a:lnum - 1) =~? '\v^}$'  " Let lone curly-brackets end folds
            return '<' . this_indent
        else
            return '-1'
        endif
    endif

    " Compare current and next indentation and set fold level as appropriate
    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif

    return '0'
endfunction

setlocal foldmethod=expr
setlocal foldexpr=NextflowFold(v:lnum)
